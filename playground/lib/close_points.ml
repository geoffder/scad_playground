open! OCADml
open OSCADml

let close_points ?convexity ?bot_pt ?top_pt layers =
  let n = List.length layers in
  let pts =
    let a = Array.make n [||] in
    let rec fill i = function
      | []       -> a
      | hd :: tl ->
        Array.unsafe_set a i (Array.of_list hd);
        fill (i + 1) tl
    in
    fill 0 layers
  in
  let p = Array.length pts.(0) in
  for i = 0 to n - 1 do
    let l = Array.length (Array.unsafe_get pts i) in
    if p <> l
    then (
      let msg =
        Printf.sprintf "Inconsistent layer length: layer %i -> %i (first = %i)." i l p
      in
      failwith msg )
  done;
  let size = n * p in
  let bot_face, loop_offset =
    match bot_pt with
    | Some _ ->
      let f i = [ 0; i + 1; i + ((i + 1) mod p) ] in
      List.init p f, 1
    | None   -> [ List.init p (fun i -> i) ], 0
  in
  let top_face =
    let top_offset = loop_offset + size - p in
    match top_pt with
    | Some _ ->
      let seal_offset = top_offset + p in
      let f i = [ seal_offset; top_offset + ((i + 1) mod p); top_offset + 1 ] in
      List.init p f
    | None   ->
      let last = loop_offset + size - 1 in
      [ List.init p (fun i -> last - i) ]
  and body_faces =
    let rec loop acc i j k =
      let acc =
        ( if k = 0
        then
          [ loop_offset + (i * p) + j
          ; loop_offset + ((i + 1) * p) + j
          ; loop_offset + ((i + 1) * p) + ((j + 1) mod p)
          ]
        else
          [ loop_offset + (i * p) + j
          ; loop_offset + ((i + 1) * p) + ((j + 1) mod p)
          ; loop_offset + (i * p) + ((j + 1) mod p)
          ] )
        :: acc
      in
      if k < 1
      then loop acc i j (k + 1)
      else if j < p - 1
      then loop acc i (j + 1) 0
      else if i < n - 2
      then loop acc (i + 1) 0 0
      else acc
    in
    loop [] 0 0 0
  in
  let points =
    let get i = Array.(unsafe_get (unsafe_get pts (i / p)) (i mod p)) in
    let f, last =
      match top_pt with
      | Some pt -> (fun i -> if i < size then get i else pt), size + 1
      | None    -> get, size
    in
    match bot_pt with
    | Some b -> b :: List.init last f
    | None   -> List.init last f
  in
  Scad.polyhedron ?convexity points (List.concat [ bot_face; body_faces; top_face ])

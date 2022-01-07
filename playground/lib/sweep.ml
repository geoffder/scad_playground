open Scad_ml

(* TODO:
   - add RotMatrix.to_string
   - basic zero and id values for Rot and Mult matrices
   - see below about making a MultMatrix from RotMatrix *)

(* I think that they do row major like this based on multmatrix, but I could be wrong. *)
let rotation_from_axis x y z = RotMatrix.of_row_list [ x; y; z ]
let rot_id = RotMatrix.of_col_list_exn [ 1., 0., 0.; 0., 1., 0.; 0., 0., 1. ]

let rotate_from_to ?ax a b =
  let ax = Option.value ~default:Vec3.(normalize (cross a b)) ax in
  if Vec3.dot a b >= 0.99
  then (
    let ma =
      (* from cols, so transposed *)
      let a' = Vec3.normalize a in
      RotMatrix.of_col_list_exn [ a'; ax; Vec3.cross ax a' ]
    and mb =
      let b' = Vec3.normalize b in
      RotMatrix.of_row_list_exn [ b'; ax; Vec3.cross ax b' ]
    in
    RotMatrix.mul mb ma )
  else rot_id

let make_orthogonal u v =
  let v' = Vec3.normalize v in
  Vec3.(normalize (u <-> (v' <*> (v' <*> v))))

(* TODO: add a MultMatrix.of_rot_matrix function to do this more cleanly. *)
let contsruct_rt r (x, y, z) =
  let g = RotMatrix.get r in
  MultMatrix.of_row_list_exn
    [ g 0 0, g 0 1, g 0 2, x
    ; g 1 0, g 1 1, g 1 2, y
    ; g 2 0, g 2 1, g 2 2, z
    ; 0., 0., 0., 1.
    ]

(* TODO:
    https://github.com/openscad/scad-utils/blob/master/transformations.scad
   - see project and transform (used in sweep)
    https://github.com/openscad/scad-utils/blob/master/linalg.scad
   - see vec3 and vec4 (used in sweep I think). Basically making vecs (lists)
    from lower dimensional ones. Probably just need to add a 1 on the end like
    in vec4?
*)
let construct_transform_path = ()
let sweep = ()

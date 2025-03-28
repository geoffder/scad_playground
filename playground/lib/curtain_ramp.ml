open! Base
    open OCADml
open! OSCADml

let nozzle = 0.4
let outer_diam = 25.5
let outer_thickness = 1.6
let inner_diam = 22.3
let insert_len = 4.
let cone_len = 20.
let gap_width = 10.
let full_len = cone_len +. insert_len +. 0.2

let scad =
  let insert = Scad.cylinder ~height:((outer_diam -. outer_thickness) /. 2.) insert_len
  and cone =
    let s = (inner_diam +. nozzle) /. outer_diam in
    Scad.extrude
      ~height:cone_len
      ~scale:(v2 s s)
      (Scad.circle ~fn:64 (outer_diam /. 2.))
    |> Scad.translate (v3 0. 0. (insert_len -. 0.001))
  and core =
    Scad.cylinder ~fn:64 ~height:(inner_diam /. 2.) full_len |> Scad.translate (v3 0. 0. (-0.1))
  and gap =
    Scad.cube ~center:true (v3 gap_width outer_diam full_len)
    |> Scad.translate (v3 0. ( outer_diam /. 2. ) (full_len /. 2. -. 0.1))
  in
  Scad.difference (Scad.union [ insert; cone ]) [ core; gap ]

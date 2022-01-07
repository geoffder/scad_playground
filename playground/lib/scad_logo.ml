open Scad_ml

let scad =
  let rad = 5.
  and fn = 720 in
  let cyl = Scad.cylinder ~fn ~center:true (rad /. 2.) (rad *. 2.3) in
  let cross_cyl = Scad.rotate (0., Float.pi /. 2., 0.) cyl in
  Scad.union
    [ Scad.difference
        (Scad.sphere ~fn rad)
        [ cyl; cross_cyl; Scad.rotate (0., 0., Float.pi /. 2.) cross_cyl ]
    ; Scad.color ~alpha:0.25 Color.Magenta cross_cyl
    ]

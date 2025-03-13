open OSCADml

let scad =
  let rad = 5.
  and fn = 720 in
  let cyl = Scad.cylinder ~fn ~center:true ~height:(rad *. 2.3)(rad /. 2.)  in
  let cross_cyl = Scad.yrot (Float.pi /. 2.) cyl in
  Scad.union
    [ Scad.difference
        (Scad.sphere ~fn rad)
        [ cyl; cross_cyl; Scad.zrot (Float.pi /. 2.) cross_cyl ]
    ; Scad.color ~alpha:0.25 Color.Magenta cross_cyl
    ]

open! Base
  open OCADml
open! OSCADml

let outer_w = 190.
let outer_h = 115.
let inner_w = 177.
let inner_h = 50.
let thickness = 2.

(* bottom-left origin coordinates *)
let inner_x = (outer_w -. inner_w) /. 2.
let inner_y = 5.

let scad =
  let outer = Scad.square @@ v2 outer_w outer_h
  and inner = Scad.square (v2 inner_w inner_h) |> Scad.translate (v2 inner_x inner_y) in
  Scad.difference outer [ inner ] |> Scad.extrude ~height:thickness

open! Base
open! OSCADml
open Playground

let write_thing ?(export = false) name scad =
  let filename ext = Printf.sprintf "../things/%s.%s" name ext in
  Stdio.printf "- %s => scad" name;
  Stdio.(Out_channel.flush stdout);
  Scad.to_file (filename "scad") scad;
  if export
  then (
    Stdio.printf " => stl\n";
    Stdio.(Out_channel.flush stdout);
    try
      Printf.sprintf
        ( if Sys.unix
        then "openscad -q -o %s --export-format binstl %s"
        else "openscad.com -q -o %s --export-format binstl %s" )
        (filename "stl")
        (filename "scad")
      |> Stdlib.Sys.command
      |> function
      | 0 -> ()
      | _ -> failwith ""
    with
    | _ -> Stdio.print_endline "Openscad export shell command failed." )
  else Stdio.print_endline ""

let () =
  Stdio.print_endline "Building (and maybe exporting) scads...";
  write_thing "curtain_ramp" Curtain_ramp.scad;
  write_thing "dash_cover" Dash_cover.scad;
  write_thing "scad_logo" Scad_logo.scad;
  write_thing "keyflower" Keyflower.assembly;
  Stdio.print_endline "Done!"

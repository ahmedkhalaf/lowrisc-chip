open Yojson ;;
open Basic.Util;;

let fd = open_in Sys.argv.(1);;
let fvh = open_out Sys.argv.(2);;
let fh = open_out Sys.argv.(3);;
let j = Basic.from_channel fd;;
let refnam = ref "";;
let rec iter lst =
    List.iter (fun (s,j) ->
                   if String.contains s '@' then
                       let ix = String.index s '@' in
                       begin
                       let base = String.sub s (ix+1) (String.length s - ix - 1) in
                       refnam := (match String.map (function '-' -> '_' | oth -> oth) (String.sub s 0 ix) with
                         | "memory" -> "mem"
                         | oth -> "io_ext_"^oth);
                       Printf.fprintf fvh "  `define DEV_MAP__%s__BASE 'h%s\n" !refnam base;
                       Printf.fprintf fh "  #define DEV_MAP__%s__BASE 0x%sllu\n" !refnam base;
                       end
                   else
                       begin

                       end;
                   match s,j with
                     | _, `Assoc lst -> iter lst
                     | _, `List lst -> iter (List.map (fun itm -> ("",itm)) lst)
                     | "size", `Int sz ->
                        Printf.fprintf fvh "  `define DEV_MAP__%s__MASK 'h%X\n" !refnam (sz-1);
                        Printf.fprintf fh "  #define DEV_MAP__%s__MASK 0x%Xllu\n" !refnam (sz-1);
                     | _, `Int n -> ()
                     | _, `Bool b -> ()
                     | _, `Float f -> ()
                     | _, `String s -> ()
                     | _, `Null -> ()
               ) lst;;
output_string fvh ("`ifndef DEV_MAP_VH\n");;
output_string fvh ("`define DEV_MAP_VH\n");;
output_string fh ("#ifndef DEV_MAP_HEADER\n");;
output_string fh ("#define DEV_MAP_HEADER\n");;
let _ = match j with `Assoc lst -> iter lst | _ -> ();;
output_string fvh ("`endif // DEV_MAP_VH\n");;
output_string fh ("#endif // DEV_MAP_HEADER\n");;

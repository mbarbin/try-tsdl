open Tsdl

let _ = lazy (Tsdl_image.Image.load "/tmp/a.png")

let main () =
  match Sdl.init Sdl.Init.(video + events) with
  | Error (`Msg e) ->
    Sdl.log "Init error: %s" e;
    exit 1
  | Ok () ->
    (match Sdl.create_window ~w:640 ~h:480 "SDL OpenGL" Sdl.Window.opengl with
     | Error (`Msg e) ->
       Sdl.log "Create window error: %s" e;
       exit 1
     | Ok w ->
       Sdl.pump_events ();
       Sdl.delay 3000l;
       Sdl.destroy_window w;
       Sdl.quit ();
       exit 0)
;;

let () = main ()

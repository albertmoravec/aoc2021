open System.IO

let processCommand (horiz, depth) (cmd, dist) =
  match cmd with
  | "forward" -> (horiz + dist, depth)
  | "up" -> (horiz, depth - dist)
  | "down" -> (horiz, depth + dist)


File.ReadLines("02.txt")
|> List.ofSeq
|> List.map (fun x -> x.Split(" ") |> List.ofSeq)
|> List.map (fun (cmd::dist::[]) -> (cmd, dist |> int))
|> List.fold processCommand (0, 0)
||> (*)
|> printfn "%i"
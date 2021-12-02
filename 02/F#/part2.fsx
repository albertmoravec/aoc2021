open System.IO

let processCommand (horiz, depth, aim) (cmd, dist) =
  match cmd with
  | "forward" -> (horiz + dist, depth + (aim * dist), aim)
  | "up" -> (horiz, depth, aim - dist)
  | "down" -> (horiz, depth, aim + dist)


File.ReadLines("02.txt")
|> List.ofSeq
|> List.map (fun x -> x.Split(" ") |> List.ofSeq)
|> List.map (fun (cmd::dist::[]) -> (cmd, dist |> int))
|> List.fold processCommand (0, 0, 0)
|||>(fun horiz depth _ -> horiz * depth)
|> printfn "%i"
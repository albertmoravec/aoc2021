open System.IO

let increases = 
  File.ReadLines("01.txt")
  |> List.ofSeq
  |> List.map int
  |> List.windowed 3
  |> List.map List.sum
  |> List.windowed 2
  |> List.where (fun (first::second::[]) -> first < second)
  |> List.length

printfn "%i" increases
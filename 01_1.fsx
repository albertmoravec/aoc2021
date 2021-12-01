open System.IO

let increases = 
  System.IO.File.ReadLines("01.txt")
  |> List.ofSeq
  |> List.map int
  |> List.windowed 2
  |> List.where (fun (first::second::[]) -> first < second)
  |> List.length

printfn "%i" increases
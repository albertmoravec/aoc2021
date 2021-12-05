File.read!("05.txt")
|> String.split("\n", trim: true)
|> Enum.map(fn line ->
  line
  |> String.split(" -> ")
  |> Enum.map(fn point ->
    point
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> then(fn [x, y] -> {x, y} end)
  end)
end)
|> Enum.map(fn
  [{x1, y1}, {x2, y2}] when x1 == x2 -> Enum.map(y1..y2, &{x1, &1})
  [{x1, y1}, {x2, y2}] when y1 == y2 -> Enum.map(x1..x2, &{&1, y1})
  [{x1, y1}, {x2, y2}] -> Enum.zip(x1..x2, y1..y2)
end)
|> List.flatten()
|> Enum.frequencies()
|> Enum.filter(fn {_, count} -> count > 1 end)
|> Enum.count()
|> IO.inspect()

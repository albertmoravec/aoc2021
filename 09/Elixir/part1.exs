neighbor_coords = fn {x, y} ->
  [
    {x + 1, y},
    {x - 1, y},
    {x, y + 1},
    {x, y - 1}
  ]
end

neighbor_values = fn map, coord ->
  coord
  |> neighbor_coords.()
  |> Enum.map(&Map.get(map, &1))
  |> Enum.reject(&is_nil/1)
end

File.read!("09.txt")
|> String.split("\n", trim: true)
|> Enum.with_index()
|> Enum.flat_map(fn {line, y} ->
  line
  |> String.codepoints()
  |> Enum.with_index()
  |> Enum.map(fn {height, x} -> {{x, y}, String.to_integer(height)} end)
end)
|> Map.new()
|> then(fn map ->
  Map.keys(map)
  |> Enum.filter(fn coord -> map[coord] < Enum.min(neighbor_values.(map, coord)) end)
  |> Enum.map(fn coord -> map[coord] + 1 end)
  |> Enum.sum()
end)
|> IO.inspect()

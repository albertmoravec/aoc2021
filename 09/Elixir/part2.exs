neighbor_coords = fn {x, y} ->
  [
    {x + 1, y},
    {x - 1, y},
    {x, y + 1},
    {x, y - 1}
  ]
end

find_basin = fn
  _self, _map, [], basin, visited ->
    {basin, visited}

  self, map, [coord | rest], basin, visited ->
    cond do
      # invalid or visited coord
      Enum.member?(visited, coord) || Map.get(map, coord) == nil ->
        self.(self, map, rest, basin, visited)

      # coord not in a basin
      Map.get(map, coord) == 9 ->
        self.(self, map, rest, basin, [coord | visited])

      # coord is in a basin
      true ->
        self.(self, map, rest ++ neighbor_coords.(coord), [coord | basin], [coord | visited])
    end
end

collect_basins = fn
  self, map, basins, visited ->
    case Map.keys(map) -- visited do
      [] ->
        basins

      [first | _] ->
        {basin, new_visited} = find_basin.(find_basin, map, [first], [], visited)
        self.(self, map, [basin | basins], new_visited)
    end
end

map_input =
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

collect_basins.(collect_basins, map_input, [], [])
|> Enum.map(&length/1)
|> Enum.sort(:desc)
|> Enum.take(3)
|> Enum.product()
|> IO.inspect()

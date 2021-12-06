fish =
  File.read!("06.txt")
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)
  |> IO.inspect(label: "Initial state")

process_day = fn fish ->
  fish
  |> then(fn fish -> fish ++ List.duplicate(9, Enum.count(fish, &(&1 == 0))) end)
  |> Enum.map(fn
    0 -> 6
    x -> x - 1
  end)
end

Enum.reduce(1..80 |> Enum.to_list(), fish, fn day, fish ->
  fish |> process_day.()
end)
|> Enum.count()
|> IO.inspect()

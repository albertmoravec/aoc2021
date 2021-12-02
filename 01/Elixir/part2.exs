{count, _last} =
  File.read!("01.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Enum.chunk_every(3, 1, :discard)
  |> Enum.map(&Enum.sum/1)
  |> Enum.reduce({0, nil}, fn current, {count, last} ->
    cond do
      is_nil(last) -> {count, current}
      current > last -> {count + 1, current}
      true -> {count, current}
    end
  end)

IO.inspect(count)

File.read!("06.txt")
|> String.split(",")
|> Enum.map(&String.to_integer/1)
|> Enum.frequencies()
|> then(fn fish ->
  for x <- 0..8, into: %{} do
    {x, Map.get(fish, x, 0)}
  end
end)
|> then(fn fish ->
  Enum.reduce(1..256 |> Enum.to_list(), fish, fn _day,
                                                 %{
                                                   0 => zero,
                                                   1 => one,
                                                   2 => two,
                                                   3 => three,
                                                   4 => four,
                                                   5 => five,
                                                   6 => six,
                                                   7 => seven,
                                                   8 => eight
                                                 } ->
    %{
      0 => one,
      1 => two,
      2 => three,
      3 => four,
      4 => five,
      5 => six,
      6 => seven + zero,
      7 => eight,
      8 => zero
    }
  end)
end)
|> Enum.map(fn {_, v} -> v end)
|> Enum.sum()
|> IO.inspect()

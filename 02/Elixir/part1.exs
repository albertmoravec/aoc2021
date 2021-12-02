File.read!("02.txt")
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, " "))
|> Enum.map(fn [command, distance] -> {command, String.to_integer(distance)} end)
|> Enum.reduce({0, 0}, fn {action, distance}, {horizontal, depth} ->
  case action do
    "forward" -> {horizontal + distance, depth}
    "up" -> {horizontal, depth - distance}
    "down" -> {horizontal, depth + distance}
  end
end)
|> tap(fn {horizontal, depth} -> "#{horizontal * depth}" end)
|> IO.puts()

File.read!("02.txt")
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, " "))
|> Enum.map(fn [command, distance] -> {command, String.to_integer(distance)} end)
|> Enum.reduce({0, 0, 0}, fn {action, distance}, {horizontal, depth, aim} ->
  case action do
    "forward" -> {horizontal + distance, depth + (aim * distance), aim}
    "up" -> {horizontal, depth, aim - distance}
    "down" -> {horizontal, depth, aim + distance}
  end
end)
|> then(fn {horizontal, depth, _aim} -> "#{horizontal * depth}" end)
|> IO.puts()

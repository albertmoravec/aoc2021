File.read!("08.txt")
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, "|"))
|> Enum.map(fn [_, digits] -> String.trim(digits) end)
|> Enum.flat_map(&String.split(&1, " "))
|> Enum.map(&String.length/1)
|> Enum.filter(&(&1 == 2 || &1 == 3 || &1 == 4 || &1 == 7))
|> Enum.count()
|> IO.inspect()
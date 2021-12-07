# Bruteforce it!!!

crabs =
  File.read!("07.txt")
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

max_postition = Enum.max(crabs)

for goto_position <- 0..max_postition do
  crabs
  |> Enum.map(fn crab -> abs(crab - goto_position) end)
  |> Enum.map(fn distance -> div(distance*(distance + 1), 2) end)
  |> Enum.sum()
end
|> Enum.min()
|> IO.inspect()

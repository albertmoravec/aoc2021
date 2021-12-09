find_mapping = fn patterns ->
  mapping = %{"a" => nil, "b" => nil, "c" => nil, "d" => nil, "e" => nil, "f" => nil, "g" => nil}

  five_segment_numbers = Enum.filter(patterns, fn digit -> MapSet.size(digit) == 5 end)
  six_segment_numbers = Enum.filter(patterns, fn digit -> MapSet.size(digit) == 6 end)

  one = Enum.find(patterns, fn digit -> MapSet.size(digit) == 2 end)
  four = Enum.find(patterns, fn digit -> MapSet.size(digit) == 4 end)
  seven = Enum.find(patterns, fn digit -> MapSet.size(digit) == 3 end)
  eight = Enum.find(patterns, fn digit -> MapSet.size(digit) == 7 end)

  mapping = Map.put(mapping, "a", MapSet.difference(seven, one))

  six = Enum.find(six_segment_numbers, fn digit -> MapSet.size(MapSet.difference(digit, one)) == 5 end)
  six_segment_numbers = six_segment_numbers -- [six]

  mapping = Map.put(mapping, "c", MapSet.difference(one, six))
  mapping = Map.put(mapping, "f", MapSet.intersection(one, seven) |> MapSet.difference(mapping["c"]))


  three = Enum.find(five_segment_numbers, fn digit -> MapSet.size(MapSet.difference(digit, one)) == 3 end)
  five_segment_numbers = five_segment_numbers -- [three]

  nine = MapSet.union(three, four)
  mapping = Map.put(mapping, "e", MapSet.difference(eight, nine))

  zero = (six_segment_numbers -- [nine]) |> hd()

  five = Enum.find(five_segment_numbers, fn digit -> MapSet.difference(digit, mapping["f"]) |> MapSet.size() == 4 end)

  two = (five_segment_numbers -- [five]) |> hd()

  %{
    zero => 0,
    one => 1,
    two => 2,
    three => 3,
    four => 4,
    five => 5,
    six => 6,
    seven => 7,
    eight => 8,
    nine => 9
  }
end

File.read!("08.txt")
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, "|"))
|> Enum.map(fn [patterns, digits] ->
  {
    patterns
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&MapSet.new/1),
    digits
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&MapSet.new/1)
  }
end)
|> Enum.map(fn {patterns, digits} -> {find_mapping.(patterns), digits} end)
|> Enum.map(fn {mapping, digits} ->
  digits
  |> Enum.map(&Map.get(mapping, &1))
  |> Integer.undigits()
end)
|> Enum.sum()
|> IO.inspect()

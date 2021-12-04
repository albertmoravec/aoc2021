defmodule Part2 do
  def invert(0), do: 1
  def invert(1), do: 0

  def most_common(numbers, pos) do
    numbers
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.at(pos)
    |> then(fn frequencies ->
      if Map.get(frequencies, 0, 0) > Map.get(frequencies, 1, 0), do: 0, else: 1
    end)
  end

  def least_common(numbers, pos), do: most_common(numbers, pos) |> invert()

  def filter_numbers(numbers, filter) when is_list(numbers),
    do: filter_numbers(numbers, 0, filter)

  def filter_numbers([number | _], pos, _filter) when pos == length(number), do: number

  def filter_numbers([number | []], _pos, _filter), do: number

  def filter_numbers(numbers, pos, filter) when is_list(numbers) do
    num = filter.(numbers, pos)

    numbers
    |> Enum.filter(fn x -> Enum.at(x, pos) == num end)
    |> filter_numbers(pos + 1, filter)
  end
end

numbers_list =
  File.read!("03.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(&String.graphemes/1)
  |> Enum.map(fn num -> Enum.map(num, &String.to_integer/1) end)

oxygen =
  numbers_list
  |> Part2.filter_numbers(&Part2.most_common/2)
  |> Integer.undigits(2)

co2 =
  numbers_list
  |> Part2.filter_numbers(&Part2.least_common/2)
  |> Integer.undigits(2)

IO.puts("#{oxygen * co2}")

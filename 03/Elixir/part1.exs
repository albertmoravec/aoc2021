gamma_digits =
  File.read!("03.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(&String.graphemes/1)
  |> Enum.map(fn num -> Enum.map(num, &String.to_integer/1) end)
  |> List.zip()
  |> Enum.map(&Tuple.to_list/1)
  |> Enum.map(&Enum.frequencies/1)
  |> Enum.map(fn %{0 => zero_count, 1 => one_count} ->
    if zero_count > one_count, do: 0, else: 1
  end)

epsilon_digits =
  gamma_digits
  |> Enum.map(fn 1 -> 0; 0 -> 1 end)

gamma = Integer.undigits(gamma_digits, 2)
epsilon = Integer.undigits(epsilon_digits, 2)

IO.puts("#{gamma * epsilon}")

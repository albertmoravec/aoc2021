input =
  File.read!("04.txt")
  |> String.split("\n", trim: true)

numbers =
  input
  |> Enum.at(0)
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)
  |> IO.inspect(label: "Number")

map_board_line = fn line ->
  line
  |> String.split()
  |> Enum.map(&{String.to_integer(&1), false})
end

boards =
  input
  |> Enum.drop(1)
  |> Enum.reject(&(&1 == ""))
  |> Enum.map(map_board_line)
  |> Enum.chunk_every(5)
  |> IO.inspect(label: "Boards")

all_true = fn line -> Enum.all?(line, &elem(&1, 1)) end

winning_board = fn board ->
  Enum.any?(board, all_true) || Enum.any?(List.zip(board) |> Enum.map(&Tuple.to_list/1), all_true)
end

mark_number = fn number, boards ->
  for board <- boards do
    for line <- board do
      Enum.map(line, fn {x, marked} -> {x, marked || x == number} end)
    end
  end
end

{winning_number, winning_board} =
  Enum.reduce_while(numbers, boards, fn number, acc ->
    marked_boards = mark_number.(number, acc) |> IO.inspect(label: "Marked board with #{number}")

    case Enum.find(marked_boards, winning_board) do
      nil -> {:cont, marked_boards}
      board -> {:halt, {number, board}}
    end
  end)

Enum.reduce(winning_board, 0, fn line, sum ->
  line
  |> Enum.reject(fn {_, marked} -> marked end)
  |> Enum.map(fn {num, _} -> num end)
  |> Enum.sum()
  |> then(&(&1 + sum))
end)
|> then(&(&1 * winning_number))
|> IO.inspect()

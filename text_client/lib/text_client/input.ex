defmodule TextClient.Input do

  alias TextClient.State

  def input_move(state = %State{}) do
    IO.gets("Your guess: ")
    |> process_input(state)
  end

  defp process_input({:error, reason}, _state) do
    IO.puts("Error on your input, exiting with reason: #{reason}")
    exit :normal
  end

  defp process_input(:eof, _state) do
    IO.puts("Seems like you initiated exit... Bye!")
    exit :normal
  end

  defp process_input(input, state) do
    input = String.trim(input)
    cond do
      input =~ ~r/\A[a-z]\z/ ->
        Map.put(state, :current_guess, input)
      true ->
        IO.puts("Please input a lowercase letter")
        input_move(state)
    end
  end

end

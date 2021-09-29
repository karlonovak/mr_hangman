defmodule TextClient.Player do

  alias TextClient.State
  alias TextClient.Summary
  alias TextClient.Input

  def play(%State{tally: %{game_state: :lost}}) do
    IO.puts("Sorry, you lost...")
    exit :normal
  end

  def play(%State{tally: %{game_state: :won}}) do
    IO.puts("Congrats, you won!")
    exit :normal
  end

  def play(state = %State{}) do
    state
    |> Summary.print()
    |> Input.input_move()
    |> make_move()
    |> play()
  end

  defp make_move(state = %State{}) do
    new_tally = Hangman.make_move(state.game, state.current_guess)
    %State{state | tally: new_tally}
  end

end

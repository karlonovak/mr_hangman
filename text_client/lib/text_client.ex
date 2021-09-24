defmodule TextClient do

  alias TextClient.State
  alias TextClient.Player

  def start_game() do
    Hangman.new_game()
    |> init_state()
    |> Player.play()
  end

  defp init_state(game) do
    %State {
      game: game,
      tally: Hangman.tally(game)
    }
  end


end

defmodule TextClient do

  alias TextClient.State
  alias TextClient.Player

  @hangman_server :"hangman@knovak-ThinkPad-T480"

  def start_game() do
    new_game()
    |> init_state()
    |> Player.play()
  end

  defp init_state(game) do
    %State {
      game: game,
      tally: Hangman.tally(game)
    }
  end

  defp new_game() do
    :rpc.call(
      @hangman_server,
      Hangman,
      :new_game,
      []
    )
  end


end

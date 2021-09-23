defmodule Hangman.Game do
  defstruct state: :initializing,
            turns_left: 7,
            letters: [],
            used: MapSet.new()

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints()
    }
  end

  def new_game() do
    new_game(Dictionary.random_word())
  end

  def make_move(game = %Hangman.Game{state: state}, _guess) when state in [:won, :lost] do
    {game, tally(game)}
  end

  def make_move(game, guess) do
    accept_move(game, guess, guess in game.used)
  end

  defp accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :state, :already_used)
  end

  defp accept_move(game, guess, _new_letter_guess) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess?(guess in game.letters)
  end

  defp score_guess?(game, _good_guess = true) do
    game_won?(game, MapSet.subset?(MapSet.new(game.letters), game.used))
  end

  defp score_guess?(game = %{turns_left: 1}, _good_guess = false) do
    Map.put(game, :state, :lost)
  end

  defp score_guess?(game, _good_guess = false) do
    %{game |
      state: :bad_guess,
      turns_left: game.turns_left - 1
    }
  end

  defp game_won?(game, _game_won = true) do
    Map.put(game, :state, :won)
  end

  defp game_won?(game, _game_not_won) do
    Map.put(game, :state, :good_guess)
  end

  def tally(game)  do
    %{
      game_state: game.state,
      turns_left: game.turns_left,
      letters: game.used |> reveal_letters(game.letters)
    }
  end

  defp reveal_letters(guessed, game_letters) do
    Enum.map(game_letters, &(reveal_letter(&1, &1 in guessed)))
  end

  defp reveal_letter(game_letter, _guessed = true), do: game_letter
  defp reveal_letter(_game_letter, _not_guessed), do: "_"

end

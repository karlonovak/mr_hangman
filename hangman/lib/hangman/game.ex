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
    accept_move(game, guess, MapSet.member?(game.used, guess))
  end

  defp accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :state, :already_used)
  end

  defp accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> good_guess?(guess in game.letters)
  end

  defp good_guess?(game, true) do
    game_won?(game, MapSet.subset?(MapSet.new(game.letters), game.used))
  end

  defp good_guess?(game, false) do
    game
  end

  defp game_won?(game, true) do
    Map.put(game, :state, :won)
  end

  defp game_won?(game, _) do
    Map.put(game, :state, :good_guess)
  end


  def tally(_game)  do
    123
  end

end

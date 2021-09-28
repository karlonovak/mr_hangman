defmodule GameTest do
  use ExUnit.Case
  alias Hangman.Game

  test "state is initialized" do
    game = Game.new_game()

    assert game.state == :initializing
    assert game.turns_left == 7
    assert length(game.letters) > 0

    assert game.letters |> List.to_string() |> String.downcase() == game.letters |> List.to_string()
  end

  test "game state is unchanged on making a move if game is :won or :lost" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:state, state)
      assert {^game, _} = Game.make_move(game, "x")
    end
  end

  test "already guessed check" do
    game = Game.new_game()

    {game, _} = Game.make_move(game, "x")
    assert game.state != :already_used

    {game, _} = Game.make_move(game, "x")
    assert game.state == :already_used
  end

  test "good guess" do
    game = Game.new_game("doodle")
    {game, _} = Game.make_move(game, "d")
    assert game.state == :good_guess
  end

  test "victory if all good guessed" do
    moves = [
      {"d", :good_guess},
      {"o", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("doodle")

    Enum.reduce(moves, game, fn({guess, state}, game) ->
      {game, _} = Game.make_move(game, guess)
      assert game.state == state
      game
    end)
  end

  test "bad guess detection" do
    game = Game.new_game("doodle")
    {game, _} = Game.make_move(game, "x")
    assert game.state == :bad_guess
    assert game.turns_left == 6
  end

  test "game lost" do
    moves = [
      {"a", :bad_guess, 6},
      {"b", :bad_guess, 5},
      {"c", :bad_guess, 4},
      {"d", :bad_guess, 3},
      {"e", :bad_guess, 2},
      {"f", :bad_guess, 1},
      {"g", :lost, 1}
    ]

    game = Game.new_game("x")

    Enum.reduce(moves, game, fn({guess, state, turns_left}, game) ->
      {game, _} = Game.make_move(game, guess)
      assert game.state == state
      assert game.turns_left == turns_left
      game
    end)
  end
end

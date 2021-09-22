defmodule GameTest do
  use ExUnit.Case
  alias Hangman.Game

  test "state is initialized" do
    game = Game.new_game()

    assert game.state == :initializing
    assert game.turns_left == 7
    assert length(game.letters) > 0
    assert game.letters |> List.to_string |> String.downcase == game.letters |> List.to_string
  end

  test "game state is unchanged on making a move if game is :won or :lost" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:state, state)
      assert {^game, _ } = Game.make_move(game, "x")
    end
  end

  test "already guessed check" do
    game = Game.new_game()

    game = Game.make_move(game, "x")
    assert game.state != :already_used

    game = Game.make_move(game, "x")
    assert game.state == :already_used
  end

  test "good guess" do
    game = Game.new_game("doodle")
    game = Game.make_move(game, "d")
    assert game.state == :good_guess
  end

  test "victory if all good guessed" do
    game = Game.new_game("doodle")
    game = Game.make_move(game, "d")
    assert game.state == :good_guess
    game = Game.make_move(game, "o")
    assert game.state == :good_guess
    game = Game.make_move(game, "l")
    assert game.state == :good_guess
    game = Game.make_move(game, "e")
    assert game.state == :won
  end

end

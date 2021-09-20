defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "state is initialized" do
    assert %Hangman.Game{state: :initializing} = Hangman.new_game()
  end
end

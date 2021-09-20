defmodule Hangman.Game do
  defstruct state: :initializing,
            turns_left: 7,
            letters: []

  def new_game() do
    %Hangman.Game{
      letters: Dictionary.random_word() |> String.codepoints()
    }
  end
end

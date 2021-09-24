defmodule TextClient.Summary do

  alias TextClient.State

  def print(state = %State{}) do
    IO.puts [
      "\n",
      "Current word: ",
      state.tally.letters,
      "\n",
      "Turns left: #{state.tally.turns_left}"
    ]
    state
  end

end

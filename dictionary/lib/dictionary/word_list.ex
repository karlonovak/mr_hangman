defmodule Dictionary.WordList do
  use Agent

  @me __MODULE__

  def start_link(_) do
    Agent.start_link(&word_list/0,name: @me)
  end

  def word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n")
  end

  def random_word() do
    Agent.get(@me, &Enum.random/1)
  end

end

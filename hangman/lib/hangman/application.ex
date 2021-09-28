defmodule Hangman.Application do

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    options = [
      name:     Hangmans.Supervisor,
      strategy: :simple_one_for_one,
    ]

    children = [
      {Hangman.Server, %{}}
    ]

    Supervisor.start_link(children, options)
  end

end

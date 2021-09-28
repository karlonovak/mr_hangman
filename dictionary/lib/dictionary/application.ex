defmodule Dictionary.Application do

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    options = [
      name:     Dictionary.Supervisor,
      strategy: :one_for_one,
    ]

    children = [
      {Dictionary.WordList, %{}}
    ]

    Supervisor.start_link(children, options)
  end

end

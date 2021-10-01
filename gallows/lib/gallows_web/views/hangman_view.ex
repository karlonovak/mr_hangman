defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def people(), do: [{"marin", 32}, {"karlo", 30}, {"ivo", 27}]

  def greeter(name, age) when age > 30, do: "hello " <> name

  def greeter(name, age) when age <= 30, do: "hello young " <> name

end

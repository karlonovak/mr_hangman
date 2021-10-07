defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def game_state(:bad_guess) do
    alert("warning", "Bad guess.")
  end

  def game_state(:already_used) do
    alert("warning", "You already used that letter, try another one...")
  end

  def game_state(:won) do
    alert("info", "Wow! You won!!!")
  end

  def game_state(:lost) do
    alert("danger", "Sorry, you lost :(")
  end

  def game_state(_) do
  end

  defp alert(class, message) do
    """
    <div class="alert alert-#{class}">
      #{message}
    </div>
  """
  |> raw()
  end

end

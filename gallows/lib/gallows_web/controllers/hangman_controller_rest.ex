defmodule GallowsWeb.HangmanControllerRest do
  use GallowsWeb, :controller

  def create_game(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    conn
    |> put_session(:game, game)
    |> json(%{tally: tally})
  end

#  def make_move(conn, params) do
#   %{"make_move" => %{"guess" => guess}} = params
#
#    tally =
#      conn
#      |> get_session(:game)
#      |> Hangman.make_move(guess)
#
#    put_in(conn.params["make_move"]["guess"], "")
#    |> render("game_field.html", tally: tally)
#  end
end

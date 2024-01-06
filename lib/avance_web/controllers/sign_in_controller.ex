defmodule AvanceWeb.Controllers.SignInController do
  use AvanceWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html", %{title: "Sign In"})
  end
end

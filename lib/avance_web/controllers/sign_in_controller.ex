defmodule AvanceWeb.Controllers.SignInController do
  @moduledoc """
  The sign in controller.
  """
  use AvanceWeb, :controller

  @doc false
  def new(conn, _params) do
    render(conn, "new.html", %{title: "Sign In"})
  end
end

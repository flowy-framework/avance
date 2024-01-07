defmodule AvanceWeb.UserSessionController do
  @moduledoc false
  use AvanceWeb, :controller

  alias AvanceWeb.UserAuth

  @doc """
  Logs out the current user.
  """
  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end

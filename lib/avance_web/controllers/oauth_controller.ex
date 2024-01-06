defmodule AvanceWeb.Controllers.OAuthController do
  use AvanceWeb, :controller
  plug(Ueberauth)

  alias Avance.Core.Users
  alias AvanceWeb.UserAuth

  def callback(
        %{
          assigns: %{
            ueberauth_auth: %{
              info: user_info,
              extra: %{raw_info: %{user: _user}}
            }
          }
        } = conn,
        %{
          "provider" => provider
        }
      ) do
    user_params = %{
      email: user_info.email,
      first_name: user_info.first_name,
      last_name: user_info.last_name,
      avatar_url: user_info.image,
      provider: provider
    }

    case Users.fetch_or_create_user(user_params) do
      {:ok, user} ->
        UserAuth.log_in_user(conn, user)

      _ ->
        conn
        |> put_flash(:error, "Authentication failed")
        |> redirect(to: "/")
    end
  end

  def callback(conn, %{"error_description" => error}) do
    conn
    |> put_flash(:error, "Authentication failed: #{error}")
    |> redirect(to: "/sign-in")
  end
end

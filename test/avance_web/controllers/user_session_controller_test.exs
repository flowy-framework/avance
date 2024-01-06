defmodule AvanceWeb.UserSessionControllerTest do
  use AvanceWeb.ConnCase, async: true

  import Avance.Tests.Fixtures.UserFixtures

  setup do
    %{user: user_fixture()}
  end

  describe "GET /sign-in" do
    test "renders log in page", %{conn: conn} do
      conn = get(conn, ~p"/sign-in")
      response = html_response(conn, 200)
      assert response =~ "Sign In"
    end
  end

  describe "DELETE /users/log-out" do
    test "logs the user out", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> delete(~p"/users/log-out")
      assert redirected_to(conn) == ~p"/"
      refute get_session(conn, :user_token)
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Logged out successfully"
    end

    test "succeeds even if the user is not logged in", %{conn: conn} do
      conn = delete(conn, ~p"/users/log-out")
      assert redirected_to(conn) == ~p"/"
      refute get_session(conn, :user_token)
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Logged out successfully"
    end
  end
end

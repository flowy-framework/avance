defmodule Avance.Support.SlackClientTest do
  use ExUnit.Case
  alias Avance.Support.SlackClient

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  test "post_message sends a POST request with correct parameters", %{bypass: bypass} do
    # Define the mock's behaviour
    Bypass.expect_once(bypass, "POST", "/webhook", fn conn ->
      Plug.Conn.resp(conn, 200, "ok")
    end)

    assert {:ok, _} =
             SlackClient.post_message(
               "#test",
               "hello there",
               webhook: endpoint_url(bypass.port, "webhook")
             )
  end

  defp endpoint_url(port, path), do: "http://localhost:#{port}/#{path}"
end

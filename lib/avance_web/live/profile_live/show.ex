defmodule AvanceWeb.ProfileLive.Show do
  @moduledoc """
  The profile live view.
  """
  use AvanceWeb, :live_view

  alias Avance.Schemas.User

  @title "Yor Profile"

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_breadcrumb_steps()
     |> assign(:title, @title)
     |> assign(:page_title, @title)
     |> assign(:show_dev_token, dev?())
     |> assign(:section, :profile)}
  end

  def dev?(), do: System.get_env("MIX_ENV", "dev") == "dev"

  @impl true
  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  defp assign_breadcrumb_steps(%{assigns: %{current_user: %{email: email}}} = socket) do
    steps = [
      %Step{label: "Home", path: "/"},
      %Step{label: email}
    ]

    socket
    |> assign(:steps, steps)
  end
end

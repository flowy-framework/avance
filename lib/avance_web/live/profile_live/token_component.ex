defmodule AvanceWeb.ProfileLive.TokenComponent do
  use AvanceWeb, :live_component

  attr(:error, :string, default: nil)
  @impl true
  def render(assigns) do
    assigns =
      assigns
      |> assign_api_token()

    ~H"""
    <div class="grid grid-cols-12 gap-4 sm:gap-5 lg:gap-6">
      <div class="col-span-12 lg:col-span-8">
        <.card title="Encoded token">
          <.copy_to_clipboard value={@encoded_token}>
            <.textarea disabled={true} label="JWT (click to copy)" value={@encoded_token} rows={10} />
          </.copy_to_clipboard>
        </.card>
      </div>
      <div class="col-span-12 lg:col-span-4">
        <.card title="Decoded token">
          <.markdown_field value={@claims} />
        </.card>
      </div>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  @impl true
  def handle_event("save", _params, socket) do
    socket
  end

  defp assign_api_token(socket) do
    {:ok, token, claims} = Flowy.Utils.JwtToken.sign()

    socket
    |> assign(:encoded_token, token)
    |> assign(:claims, formatted_claims(claims |> Jason.encode!(pretty: true)))
  end

  defp formatted_claims(claims) do
    """
    ```json
    #{claims}
    ```
    """
  end
end

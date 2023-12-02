defmodule Avance.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :avance,
    adapter: Ecto.Adapters.Postgres
end

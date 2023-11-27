defmodule Avance.Repo do
  use Ecto.Repo,
    otp_app: :avance,
    adapter: Ecto.Adapters.Postgres
end

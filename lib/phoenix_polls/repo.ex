defmodule PhoenixPolls.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_polls,
    adapter: Ecto.Adapters.Postgres
end

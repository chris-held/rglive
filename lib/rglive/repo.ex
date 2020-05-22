defmodule Rglive.Repo do
  use Ecto.Repo,
    otp_app: :rglive,
    adapter: Ecto.Adapters.Postgres
end

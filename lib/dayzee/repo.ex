defmodule Dayzee.Repo do
  use Ecto.Repo,
    otp_app: :dayzee,
    adapter: Ecto.Adapters.Postgres
end

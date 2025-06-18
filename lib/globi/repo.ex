defmodule Globi.Repo do
  use Ecto.Repo,
    otp_app: :globi,
    adapter: Ecto.Adapters.Postgres
end

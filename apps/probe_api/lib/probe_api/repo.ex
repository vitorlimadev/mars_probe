defmodule ProbeApi.Repo do
  use Ecto.Repo,
    otp_app: :probe_api,
    adapter: Ecto.Adapters.Postgres
end

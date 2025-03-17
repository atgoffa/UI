defmodule AtgoffaUi.Repo do
  use Ecto.Repo,
    otp_app: :atgoffa_ui,
    adapter: Ecto.Adapters.Postgres
end

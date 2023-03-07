defmodule Lazycat.Repo do
  use Ecto.Repo,
    otp_app: :lazycat,
    adapter: Ecto.Adapters.Postgres
end

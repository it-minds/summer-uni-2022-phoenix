defmodule SummerUni.Repo do
  use Ecto.Repo,
    otp_app: :summeruni,
    adapter: Ecto.Adapters.Postgres
end

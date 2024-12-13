defmodule MultiSelectExample.Repo do
  use Ecto.Repo,
    otp_app: :multi_select_example,
    adapter: Ecto.Adapters.SQLite3
end

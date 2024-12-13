defmodule MultiSelectExample.Things.Thing do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "things" do
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(thing, attrs) do
    thing
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end

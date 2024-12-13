defmodule MultiSelectExample.Examples.Example do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "examples" do
    belongs_to :thing, MultiSelectExample.Things.Thing, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(example, attrs) do
    example
    |> cast(attrs, [:thing_id])
    |> validate_required([])
  end
end

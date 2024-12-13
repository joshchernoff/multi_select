defmodule MultiSelectExample.Repo.Migrations.CreateExamples do
  use Ecto.Migration

  def change do
    create table(:examples, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :thing_id, references(:things, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:examples, [:thing_id])
  end
end

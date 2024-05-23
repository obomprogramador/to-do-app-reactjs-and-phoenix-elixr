defmodule App.Repo.Migrations.CreateToDosTable do
  use Ecto.Migration

  def change do
    create table("to_dos") do
      add :description, :string
      add :status, :boolean
      add :user_id, references(:users)

      timestamps()
    end
  end
end

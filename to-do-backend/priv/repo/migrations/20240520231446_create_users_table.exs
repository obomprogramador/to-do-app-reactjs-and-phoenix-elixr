defmodule App.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string
      add :password_hash, :string
      add :email, :string
      add :zip_code, :string

      timestamps()
    end

    create(
      unique_index(
        "users",
        [:email],
        name: :index_for_users_by_uniq_email
      )
    )
  end
end

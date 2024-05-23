defmodule App.Users.Create do
  alias App.Users.User
  alias App.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end

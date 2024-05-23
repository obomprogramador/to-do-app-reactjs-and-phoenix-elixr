defmodule App.Users.Delete do
  alias App.Users.User
  alias App.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> Repo.delete(user)
    end
  end
end

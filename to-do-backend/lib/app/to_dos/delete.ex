defmodule App.ToDos.Delete do
  alias App.ToDos.ToDo
  alias App.Repo

  def call(id) do
    case Repo.get(ToDo, id) do
      nil -> {:error, :not_found}
      to_do -> Repo.delete(to_do)
    end
  end
end

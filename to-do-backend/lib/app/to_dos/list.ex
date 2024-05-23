defmodule App.ToDos.List do
  alias App.ToDos.ToDo
  alias App.Repo

  def call() do
    case Repo.all(ToDo) do
      nil -> {:error, :not_found}
      to_do_list -> {:ok, to_do_list}
    end
  end
end

defmodule App.ToDos.Create do
  alias App.ToDos.ToDo
  alias App.Repo

  def call(params) do
    params
    |> ToDo.changeset()
    |> Repo.insert()
  end
end

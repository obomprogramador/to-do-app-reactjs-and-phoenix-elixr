defmodule App.ToDos do
  alias App.ToDos.Create
  alias App.ToDos.List
  alias App.ToDos.Update
  alias App.ToDos.Delete

  defdelegate create_one(params), to: Create, as: :call
  defdelegate get_all(), to: List, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate delete_one(id), to: Delete, as: :call
end

defmodule App.Users do
  alias App.Users.Create
  alias App.Users.Get
  alias App.Users.Update
  alias App.Users.Delete
  alias App.Users.Verify

  defdelegate create_one(params), to: Create, as: :call
  defdelegate get_one_by_id(id), to: Get, as: :call
  defdelegate update_one(params), to: Update, as: :call
  defdelegate delete_one(id), to: Delete, as: :call
  defdelegate authenticate(param), to: Verify, as: :call
end

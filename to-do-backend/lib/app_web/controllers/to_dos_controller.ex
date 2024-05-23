defmodule AppWeb.ToDosController do
  use AppWeb, :controller

  alias App.ToDos
  alias ToDos.ToDo

  action_fallback AppWeb.FallbackController

  def create(conn, params) do
    with {:ok, %ToDo{} = to_do} <- ToDos.create_one(params) do
      conn
      |> put_status(:created)
      |> render(:create, to_do: to_do)
    end
  end

  def index(conn, _params) do
    with {:ok, to_do_list} <- ToDos.get_all() do
      conn
      |> put_status(:ok)
      |> render(:list, to_do_list: to_do_list)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %ToDo{} = to_do} <- ToDos.delete_one(id) do
      conn
      |> put_status(:ok)
      |> render(:delete, to_do: to_do)
    end
  end

  ###############################################################
  ########### Non default routes ################################
  ###############################################################

  def update_many(conn, params) do
    with {:ok, to_do_list} <- ToDos.update(params) do
      conn
      |> put_status(:ok)
      |> render(:update, to_do_list: to_do_list)
    end
  end
end

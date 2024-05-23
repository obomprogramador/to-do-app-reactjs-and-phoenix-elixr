defmodule AppWeb.UsersController do
  use AppWeb, :controller

  alias App.Users
  alias Users.User
  alias AppWeb.Token

  action_fallback AppWeb.FallbackController

  # A bad way to treat errors
  # def create(conn, params) do
  #   params
  #   |> Create.call()
  #   |> handle_response(conn)
  # end

  # defp handle_response({:ok, user}, conn) do
  #   conn
  #   |> put_status(:created)
  #   |> render(:create, user: user)
  # end

  # defp handle_response({:error, changeset}, conn) do
  #   conn
  #   |> put_status(:bad_request)
  #   |> put_view(json: App.ErrorJSON)
  #   |> render(:error, changeset: changeset)
  # end

  ################################################################
  ########## The better way to control errors and exceptions #####
  ################################################################

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create_one(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get_one_by_id(id) do
      conn
      |> put_status(:ok)
      |> render(:get, user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Users.update_one(params) do
      conn
      |> put_status(:ok)
      |> render(:update, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.delete_one(id) do
      conn
      |> put_status(:ok)
      |> render(:delete, user: user)
    end
  end

  ###############################################################
  ########### Not default routes ################################
  ###############################################################

  def authenticate(conn, params) do
    with {:ok, %User{} = user} <- Users.authenticate(params) do
      token = Token.sign(user)

      conn
      |> put_status(:ok)
      |> render(:authenticate, token: token)
    end
  end
end

defmodule AppWeb.Plugs.Auth do
  import Plug.Conn
  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"), {:ok, data} <- AppWeb.Token.verify(token) do
      assign(conn, :user_id, data)
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(json: AppWeb.ErrorJSON)
        |> Phoenix.Controller.render(:error, status: :unauthorized)
        |> halt() # Kill the connection.
    end
  end
end

defmodule AppWeb.UsersJSON do
  alias App.Users.User

  def create(%{user: user}) do
    %{
      message: "User created as success!",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: data(user)}
  def update(%{user: user}), do: %{message: "User change as success!", data: data(user)}
  def delete(%{user: user}), do: %{message: "User deleted as success!", data: data(user)}
  def authenticate(%{token: token}), do: %{message: "Token is valid only by 30 min!", bearer: token}

  defp data(%User{} = user) do
    %{
      id: user.id,
      zip_code: user.zip_code,
      email: user.email,
      name: user.name
    }
  end
end

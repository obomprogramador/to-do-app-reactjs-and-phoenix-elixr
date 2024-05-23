defmodule AppWeb.UsersFactory do
  use ExMachina.Ecto, repo: App.Repo

  alias App.Users.User

  def get_map_valid_user_factory do
    %{
      name: "User stored 1",
      virtual_password: "123456789101112131415",
      email: "teste@gmail.com",
      zip_code: "12345678"
    }
  end

  def get_map_invalid_user_factory do
    %{
      name: "User 1",
      virtual_password: "123456",
      email: "teste@hotmail.com",
      zip_code: "12345"
    }
  end

  def get_map_user_authenticated_factory do
    %{
      email: "teste@gmail.com",
      virtual_password: "123456789101112131415"
    }
  end

  def user_valid_to_be_stored_factory do
    %User{
      name: "User stored 1",
      virtual_password: "123456789101112131415",
      email: "teste@gmail.com",
      zip_code: "12345678"
    }
  end
end

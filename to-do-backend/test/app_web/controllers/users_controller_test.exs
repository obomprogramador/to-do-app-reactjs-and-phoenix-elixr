defmodule AppWeb.UsersControllerTest do
  use AppWeb.ConnCase

  import AppWeb.UsersFactory

  alias App.Users
  alias Users.User
  alias App.Repo

  describe "authenticate/2" do
    test "Validate user and return token!", %{conn: conn} do
      builded_user = build(:get_map_valid_user)

      {:ok, %User{email: email}} = Users.create_one(builded_user)

      params = build(:get_map_user_authenticated, email: email)

      response =
        conn
        |> post(~p"/api/users/authenticate", params)
        |> json_response(:ok)

      assert %{
        "message" => "Token is valid only by 30 min!",
        "bearer" => _token
      } = response
    end
  end

  describe "show/2" do
    test "Show a specific user!", %{conn: conn} do
      builded_user = build(:get_map_valid_user)

      {:ok, user} = Users.create_one(builded_user)
      token = AppWeb.Token.sign(user)

      %User{id: id} = user

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> get(~p"/api/users/#{id}")
        |> json_response(:ok)

      assert %{
        "data" => %{
          "zip_code" => "12345678",
          "email" => "teste@gmail.com",
          "id" => ^id,
          "name" => "User stored 1"
        }
      } = response
    end
  end

  describe "create/2" do
    test "User created as success!", %{conn: conn} do
      response =
        conn
        |> post(~p"/api/users", build(:get_map_valid_user))
        |> json_response(:created)

      assert %{
        "data" => %{
          "id" => _id,
          "name" => "User stored 1",
          "email" => "teste@gmail.com",
          "zip_code" => "12345678"
        },
        "message" => "User created as success!"
      } = response
    end

    test "Validate data, when params is invalid!", %{conn: conn} do
      expected_resp = %{
        "errors" => %{
          "zip_code" => ["should be 8 character(s)"],
          "email" => ["has invalid format"],
          "name" => ["should be at least 10 character(s)"],
          "virtual_password" => ["should be at least 15 character(s)"]
        }
      }

      response =
        conn
        |> post(~p"/api/users", build(:get_map_invalid_user))
        |> json_response(:bad_request)

      assert response == expected_resp
    end
  end

  describe "delete/2" do
    test "User created as success!", %{conn: conn} do
      builded_user = build(:get_map_valid_user)

      {:ok, user} = Users.create_one(builded_user)
      token = AppWeb.Token.sign(user)

      %User{id: id} = user

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> delete(~p"/api/users/#{id}")
        |> json_response(:ok)

      assert %{
        "data" => %{
          "id" => ^id,
          "name" => "User stored 1",
          "email" => "teste@gmail.com",
          "zip_code" => "12345678"
        },
        "message" => "User deleted as success!"
      } = response
    end

    test "User not founded!", %{conn: conn} do
      builded_user = build(:get_map_valid_user)

      {:ok, user} = Users.create_one(builded_user)
      token = AppWeb.Token.sign(user)

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> delete(~p"/api/users/9999")
        |> json_response(:not_found)

      assert 1 = length(Repo.all(User))
      assert response == %{"message" => "The tupple was not found!", "status" => "not_found"}
    end
  end
end

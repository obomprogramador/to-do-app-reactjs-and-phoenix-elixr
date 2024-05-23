defmodule AppWeb.ToDosControllerTest do
  use AppWeb.ConnCase

  import AppWeb.UsersFactory

  alias App.ToDos
  alias ToDos.ToDo

  alias App.Users
  # alias Users.User

  alias App.Repo

  describe "index/2" do
    test "Show a list of to dos!", %{conn: conn} do
      builded_user = build(:get_map_valid_user)

      {:ok, user} = Users.create_one(builded_user)
      token = AppWeb.Token.sign(user)

      builded_todo1 = %{description: "Description test 0001", status: true}
      builded_todo2 = %{description: "Description test 0002", status: true}
      builded_todo3 = %{description: "Description test 0003", status: false}

      ToDos.create_one(builded_todo1)
      ToDos.create_one(builded_todo2)
      ToDos.create_one(builded_todo3)

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> get(~p"/api/to_dos")
        |> json_response(:ok)

      assert  %{
        "data" => [
          %{"description" => "Description test 0001", "id" => _id, "status" => true},
          %{"description" => "Description test 0002", "id" => _id2, "status" => true},
          %{"description" => "Description test 0003", "id" => _id3, "status" => false}
        ]
      } = response
    end

    test "Show a empty list when has no to dos!", %{conn: conn} do
      builded_user = build(:get_map_valid_user)

      {:ok, user} = Users.create_one(builded_user)
      token = AppWeb.Token.sign(user)

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> get(~p"/api/to_dos")
        |> json_response(:ok)

      assert %{"data" => []} = response
    end
  end

  describe "create/2" do
    test "ToDo created as success!", %{conn: conn} do
      builded_user = build(:get_map_valid_user)

      {:ok, user} = Users.create_one(builded_user)
      token = AppWeb.Token.sign(user)

      params =  %{description: "Description test 0001", status: true}

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> post(~p"/api/to_dos", params)
        |> json_response(:created)

      assert  %{
        "data" => %{
          "description" => "Description test 0001",
          "id" => _id,
          "status" => true
        },
        "message" => "ToDo created as success!"
      } = response
    end
  end

  describe "delete/2" do
    test "ToDo deleted as success!", %{conn: conn} do
      builded_user = build(:get_map_valid_user)

      {:ok, user} = Users.create_one(builded_user)
      token = AppWeb.Token.sign(user)

      builded_todo1 = %{description: "Description test 0001", status: false}
      {:ok, todo1} = ToDos.create_one(builded_todo1)

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> delete(~p"/api/to_dos/#{todo1.id}")
        |> json_response(:ok)

      assert %{
        "data" => %{
          "description" => "Description test 0001",
          "id" => _id,
          "status" => false
        },
        "message" => "ToDo deleted as success!"
      } = response
    end

    test "ToDo not founded!", %{conn: conn} do
      builded_user = build(:get_map_valid_user)

      {:ok, user} = Users.create_one(builded_user)
      token = AppWeb.Token.sign(user)

      builded_todo1 = %{description: "Description test 0001", status: false}
      ToDos.create_one(builded_todo1)

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> delete(~p"/api/to_dos/9999")
        |> json_response(:not_found)

      assert 1 = length(Repo.all(ToDo))
      assert response == %{"message" => "The tupple was not found!", "status" => "not_found"}
    end
  end

  describe "update_many/2" do
    test "ToDo(s) updated as success!", %{conn: conn} do
      builded_user = build(:get_map_valid_user)

      {:ok, user} = Users.create_one(builded_user)
      token = AppWeb.Token.sign(user)

      builded_todo1 = %{description: "Description test 0001", status: false}
      builded_todo2 = %{description: "Description test 0002", status: true}

      {:ok, todo1} = ToDos.create_one(builded_todo1)
      {:ok, todo2} = ToDos.create_one(builded_todo2)

      params = %{"to_do_list" => [
        %{"id" => todo1.id, "description" => "Description modfied to other sume.", "status" => true},
        %{"id" => todo2.id, "description" => "Do somenting to someone!", "status" => false}
      ]}

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> put_req_header("content-type", "application/json")
        |> post(~p"/api/to_dos/update", params)
        |> json_response(:ok)

      assert %{
        "data" => [
          %{
            "description" => "Description modfied to other sume.",
            "id" => _id1,
            "status" => true
          },
          %{
            "description" => "Do somenting to someone!",
            "id" => _id2,
            "status" => false
          }
        ],
        "message" => "ToDo(s) changed as success!"
      } = response
    end
  end
end

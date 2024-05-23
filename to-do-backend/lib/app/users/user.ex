defmodule App.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset
  alias App.ToDos.ToDo

  @required_params_create [:name, :virtual_password, :email, :zip_code]
  @required_params_update [:name, :email, :zip_code]

  schema "users" do
    field :name, :string
    field :virtual_password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :zip_code, :string

    has_many :to_do, ToDo

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params)

  def changeset(%__MODULE__{} = user, params) do
    parse_create_changeset(user, params)
  end

  def changeset(%__MODULE__{id: nil} = user, params) do
    parse_create_changeset(user, params)
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_params_create)
    |> do_validations(@required_params_update)
  end

  defp parse_create_changeset(user, params) do
    user
    |> cast(params, @required_params_create)
    |> do_validations(@required_params_create)
  end

  defp do_validations(changeset, required_params) do
    changeset
    |> validate_required(required_params)
    |> validate_length(:name, min: 10)
    |> validate_format(:email, ~r/@gmail.com/)
    |> validate_length(:zip_code, is: 8)
    |> validate_length(:virtual_password, min: 15)
    |> unique_constraint(:email, name: :index_for_users_by_uniq_email)
    |> parse_password()
  end

  defp parse_password(%Changeset{valid?: true, changes: %{virtual_password: password}} = changeset) do
    # This function is deprecated!
    change(changeset, Argon2.add_hash(password))
    # I left warning to show you that I search for a solution to this problem and I know how to solve it
    # with this code below.
    ####################################################################################################
    ################## change(changeset, Argon2.hash_pwd_salt(password, 16)) ###########################
    ####################################################################################################
  end

  defp parse_password(changeset), do: changeset
end

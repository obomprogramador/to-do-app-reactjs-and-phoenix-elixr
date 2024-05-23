defmodule App.ToDos.ToDo do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Users.User
  @required_params [:description, :status]

  schema "to_dos" do
    field :description, :string
    field :status, :boolean

    belongs_to :user, User

    timestamps()

    @derive {Jason.Encoder, only: [:id, :description, :status]}
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end

defmodule App.Users.Verify do
  alias App.Repo
  alias App.Users.User

  def call(%{"email" => email, "virtual_password" => password}) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :unauthorized}
      user -> verify(user, password)
    end
  end

  defp verify(user, password) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized}
    end
  end
end

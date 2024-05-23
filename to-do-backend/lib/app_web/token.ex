defmodule AppWeb.Token do
  alias AppWeb.Endpoint
  alias Phoenix.Token

  @sign_salt "api_to_do_completly"

  def sign(user), do: Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  def verify(token), do: Token.verify(Endpoint, @sign_salt, token, max_age: 3600)
end

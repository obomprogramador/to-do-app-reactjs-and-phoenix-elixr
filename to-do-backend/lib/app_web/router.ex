defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug AppWeb.Plugs.Auth
  end

  scope "/api", AppWeb do
    pipe_through :api

    post "/users", UsersController, :create
    post "/users/authenticate", UsersController, :authenticate
  end

  scope "/api", AppWeb do
    pipe_through [:api, :auth]

    resources "/users", UsersController, only: [:update, :delete, :show]

    resources "/to_dos", ToDosController, only: [:create, :delete, :index]
    post "/to_dos/update", ToDosController, :update_many
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AppWeb.Telemetry
    end
  end
end

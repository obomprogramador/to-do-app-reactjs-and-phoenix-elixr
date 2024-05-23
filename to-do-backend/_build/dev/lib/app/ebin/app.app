{application,app,
             [{compile_env,[{app,['Elixir.AppWeb.Gettext'],error},
                            {app,[dev_routes],{ok,true}}]},
              {optional_applications,[]},
              {applications,[kernel,stdlib,elixir,ex_machina,logger,
                             runtime_tools,phoenix,phoenix_ecto,ecto_sql,
                             postgrex,phoenix_live_dashboard,
                             telemetry_metrics,telemetry_poller,gettext,jason,
                             dns_cluster,bandit,argon2_elixir,cors_plug]},
              {description,"app"},
              {modules,['Elixir.App','Elixir.App.Application',
                        'Elixir.App.Repo','Elixir.App.ToDos',
                        'Elixir.App.ToDos.Create','Elixir.App.ToDos.Delete',
                        'Elixir.App.ToDos.List','Elixir.App.ToDos.ToDo',
                        'Elixir.App.ToDos.Update','Elixir.App.Users',
                        'Elixir.App.Users.Create','Elixir.App.Users.Delete',
                        'Elixir.App.Users.Get','Elixir.App.Users.Update',
                        'Elixir.App.Users.User','Elixir.App.Users.Verify',
                        'Elixir.AppWeb','Elixir.AppWeb.Endpoint',
                        'Elixir.AppWeb.ErrorJSON',
                        'Elixir.AppWeb.FallbackController',
                        'Elixir.AppWeb.Gettext','Elixir.AppWeb.Plugs.Auth',
                        'Elixir.AppWeb.Router','Elixir.AppWeb.Telemetry',
                        'Elixir.AppWeb.ToDosController',
                        'Elixir.AppWeb.ToDosJSON','Elixir.AppWeb.Token',
                        'Elixir.AppWeb.UsersController',
                        'Elixir.AppWeb.UsersJSON',
                        'Elixir.Jason.Encoder.App.ToDos.ToDo']},
              {registered,[]},
              {vsn,"0.1.0"},
              {mod,{'Elixir.App.Application',[]}}]}.
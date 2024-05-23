# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias App.Users

# Admin user created by default
Users.create_one(%{
  name: "Admin user has all access",
  email: "admin@gmail.com",
  virtual_password: "123456789101112131415",
  zip_code: "12345678"
})

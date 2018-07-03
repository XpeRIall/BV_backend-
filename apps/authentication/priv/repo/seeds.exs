# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Authentication.Repo.insert!(%Authentication.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Authentication.Repo
alias Authentication.User

for _ <- 0..10000 do
  Repo.insert!(%User{
    login: Faker.Internet.user_name(),
    email: Faker.Internet.email(),
    first_name: Faker.Name.first_name(),
    last_name: Faker.Name.last_name()
  })
end

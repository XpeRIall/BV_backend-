defmodule Authentication.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Authentication.Repo

  object :user do
    field(:id, :id)
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:login, :string)
    field(:password_hash, :string)
  end
end

defmodule Authentication.Schema do
  use Absinthe.Schema

  import_types(Authentication.Schema.Types)

  query do
    field :users, list_of(:user) do
      resolve(&Authentication.Resolvers.UserResolver.all/2)
    end

    field :user, type: :user do
      arg(:id, non_null(:id))
      resolve(&Authentication.Resolvers.UserResolver.find/2)
    end
  end
end

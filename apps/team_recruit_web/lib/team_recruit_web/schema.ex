defmodule TeamRecruitWeb.Schema do
  use Absinthe.Schema

  alias TeamRecruitWeb.Data

  import_types(Absinthe.Type.Custom)
  import_types(TeamRecruitWeb.Schema.UserTypes)


  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Data, Data.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _field, _object) do
    [] ++ middleware
  end
end

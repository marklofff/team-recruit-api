defmodule TeamRecruit.Representer.Map do
  @moduledoc """
  from https://github.com/edubkendo/kitsune 
  """
  defmacro __using__(_opts) do
    quote do
      import TeamRecruit.Representer.Map
      @properties []
      @collections []
      @before_compile TeamRecruit.Representer.Map
    end
  end

  defmacro property(label, opts \\ []) do
    as = Keyword.get(opts, :as, label)
    quote do
      @properties [{unquote(label), unquote(as)}|@properties]
    end
  end

  defmacro collection(label, opts \\ []) do
    as = Keyword.get(opts, :as, label)
    extend = Keyword.get(opts, :extend)
    from = Keyword.get(opts, :from)
    quote do
      @collections [%{
        label: unquote(label),
        as: unquote(as),
        extend: unquote(extend),
        from: unquote(from)
      } | @collections ]
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def to_map(map, struct) do
        new_struct = struct_from_map(map, struct)
        _map_from_collections(new_struct)
        |> _map_from_properties(new_struct)
      end

      defp _map_from_collections(struct) do
        for %{label: label, as: as, extend: extend} <- @collections, into: %{} do
          { label, Enum.map( Map.get(struct, as), fn(x) ->
            extend.map_json(x)
          end) }
        end
      end

      defp _map_from_properties(map, struct) do
        for {label, as} <- @properties, into: map do
          { label, Map.get(struct, as) }
        end
      end

      defp struct_from_map(a_map, as: a_struct) do
        # https://medium.com/@kay.sackey/create-a-struct-from-a-map-within-elixir-78bf592b5d3b
        # Find the keys within the map
        keys = Map.keys(a_struct) 
               |> Enum.filter(fn x -> x != :__struct__ end)

        # Process map, checking for both string / atom keys
        processed_map =
          for key <- keys, into: %{} do
            value = Map.get(a_map, key) || Map.get(a_map, to_string(key))
            {key, value}
          end

        Map.merge(a_struct, processed_map)
      end
    end
  end
end

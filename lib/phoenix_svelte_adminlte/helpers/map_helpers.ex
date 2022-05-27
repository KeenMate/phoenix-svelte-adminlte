defmodule PhoenixSvelteAdminlte.MapHelpers do
  def camel_cased_map_keys(map) when is_map(map) do
    for {key, val} <- map, into: %{} do
      {Inflex.camelize(key, :lower), camel_cased_map_keys(val)}
    end
  end

  def camel_cased_map_keys(val), do: val

  def to_compact_map(map) when is_map(map) do
    map
    |> Enum.reject(fn({_, v}) -> v == nil end)
    |> Enum.into(%{})
  end

  def camelize_array(array) do
    array|> Enum.map(fn x ->
      x |> Map.from_struct() |> camel_cased_map_keys() |> to_compact_map()
    end)
  end
end

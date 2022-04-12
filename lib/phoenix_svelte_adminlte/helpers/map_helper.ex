defmodule PhoenixSvelteAdminlte.MapHelpers do
  def camel_cased_map_keys(map) when is_map(map) do
    for {key, val} <- map, into: %{} do
      {Inflex.camelize(key, :lower), camel_cased_map_keys(val)}
    end
  end

  def camel_cased_map_keys(val), do: val
end

defmodule DhlStartWeb.JsonHelpers do

  @spec encode_enum([struct() | map()]) :: binary() | {:error, any()}
  def encode_enum(enum) when is_list(enum) do
    with mapped_enum <- Enum.map(enum, &maybe_from_struct/1),
         {:ok, encoded} <- Jason.encode(mapped_enum, escape: :html_safe) do
      encoded
    end
  end

  defp maybe_from_struct(%{__struct__: _} = struct) do
    Map.from_struct(struct)
  end

  defp maybe_from_struct(other) do
    other
  end
end
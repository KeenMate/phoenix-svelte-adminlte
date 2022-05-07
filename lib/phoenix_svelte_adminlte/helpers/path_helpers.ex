defmodule PhoenixSvelteAdminlte.Helpers.PathHelpers do
  # alias Pluto.Settings.Helpers, as: Settings

  def priv_path(rest) when not is_binary(rest) do
    {:err, "Cannot create priv path for non-string parameter"}
  end

  def priv_path(rest) do
    Path.join(:code.priv_dir(:phoenix_svelte_adminlte), rest)
  end

  def upload_dir() do
    # Settings.upload_directory()
    "upload"
    |> priv_path()
  end

  def image_dir() do
    # Settings.image_directory()
    "media/images"
    |> priv_path()
  end

  @doc """
  Returns filename without any nesting nor extension

  ## Examples
      iex> get_filename("/a/b/file.txt")
      "file"
  """
  def get_filename(path) do
    path
    |> Path.rootname()
    |> Path.basename()
  end
end

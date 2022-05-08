defmodule PhoenixSvelteAdminlte.Helpers.FileHelpers do
  @moduledoc """
  Functions that can come in handy when accessing FileSystem..
  """

  require Logger

  @doc """
  Returns list of file paths that are combined with given dir
  """
  def map_files_only(dir) do
    with {:ok, content} <- File.ls(dir) do
      {
        :ok,
        content
        |> Enum.map(&Path.join(dir, &1))
        |> Enum.filter(&File.regular?/1)
      }
    else
      {:error, _} = err ->
        err
    end
  end

  @doc """
  Returns list of dir paths that are combined with given dir
  """
  def map_dirs_only(dir) do
    with {:ok, content} <- File.ls(dir) do
      {
        :ok,
        content
        |> Enum.map(&Path.join(dir, &1))
        |> Enum.filter(&File.dir?/1)
      }
    else
      {:error, _} = err ->
        err
    end
  end

  @doc """
  Function used to sort files based on modified date in given order
  """
  @spec file_dates_comparer(String.t(), String.t(), :asc | :desc) :: boolean()
  def file_dates_comparer(path1, path2, sort) do
    with {:ok, stats1} <- File.lstat(path1, time: :posix),
         %{mtime: date1} <- stats1,
         {:ok, stats2} <- File.lstat(path2, time: :posix),
         %{mtime: date2} <- stats2 do
      numbers_comparer(date1, date2, sort)
    else
      {:error, err} ->
        Logger.error(
          "Error while retrieving stats of files: \"#{path1}\", \"#{path2}\". Reason: #{err}"
        )

        nil

      invalid_stats ->
        IO.inspect(invalid_stats, "Received invalid stats of file. Was expecting field :mtime")

        nil
    end
  end

  defp numbers_comparer(number1, number2, :asc), do: number1 <= number2

  defp numbers_comparer(number1, number2, :desc), do: number1 >= number2

  defp numbers_comparer(number1, number2, _), do: numbers_comparer(number1, number2, :asc)
end

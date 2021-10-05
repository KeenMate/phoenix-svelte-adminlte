defmodule PhoenixSvelteAdminlteWeb.UsersChannel do
  use PhoenixSvelteAdminlteWeb, :channel
  import PhoenixSvelteAdminlte.Users

  require Logger

  @impl true
  def join("users:lobby", _, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("get_users", params, socket) do
    {:reply, {:ok, params |> Map.get("search") |> get_users()}, socket}
  end

  @impl true
  def handle_in("get_user", %{"user_id" => user_id}, socket) do
    {:reply, {:ok, get_user(user_id)}, socket}
  end

  defp get_users(search) when is_binary(search) and search != "" do
    get_all_users()
    |> Enum.filter(fn user ->
      String.contains?(String.downcase(user.username), search) ||
        String.contains?(String.downcase(user.first_name), search) ||
        String.contains?(String.downcase(user.last_name), search)
    end)
  end

  defp get_users(_), do: get_all_users()
end

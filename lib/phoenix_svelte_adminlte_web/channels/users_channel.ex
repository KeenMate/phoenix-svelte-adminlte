defmodule PhoenixSvelteAdminlteWeb.UsersChannel do
  use PhoenixSvelteAdminlteWeb, :channel
  import PhoenixSvelteAdminlte.Users

  require Logger

  @impl true
  def join("users:lobby", _, socket) do
    IO.puts("Users lobby join")

    {:ok, socket}
  end

  @impl true
  def handle_in("get_all_users", _params, socket) do
    IO.puts("Get all users called")

    {:reply, {:ok, get_all_users()}, socket}
  end
end

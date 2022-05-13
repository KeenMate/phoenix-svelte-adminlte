defmodule PhoenixSvelteAdminlte.Scheduler.DbJobs do
  use GenServer

  # Callbacks

  def set_jobs(jobs) do
    GenServer.cast(__MODULE__, {:set, jobs})
  end

  def get_jobs() do
    GenServer.call(__MODULE__, {:get})
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl true
  def handle_cast({:set, jobs}, _) do
    {:noreply, jobs}
  end

  @impl true
  def handle_call({:get}, _from, state) do
    {:reply, state, state}
  end
end

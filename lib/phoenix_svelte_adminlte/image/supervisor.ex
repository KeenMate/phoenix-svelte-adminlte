defmodule PhoenixSvelteAdminlte.Image.Supervisor do
  use Supervisor

  alias PhoenixSvelteAdminlte.Image

  def start_link(_) do
    children = [
      Image.ProcessedImagesPubSub,
      worker_pool_spec(),
      Image.Queue,
      Image.Maid
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end

  @impl true
  def init(arg) do
    {:ok, arg}
  end

  # SPECs

  defp worker_pool_spec do
    poolboy_name = :image_worker_poolboy

    :poolboy.child_spec(
      poolboy_name,
      [
        name: {:local, poolboy_name},
        worker_module: Image.PilWorker,
        size: 4,
        strategy: :fifo
      ],
      Path.join(:code.priv_dir(:phoenix_svelte_adminlte), "python")
    )
  end
end

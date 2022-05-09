defmodule PhoenixSvelteAdminlteWeb.PhotoChannel do
  use PhoenixSvelteAdminlteWeb, :channel

  intercept(["image_processed"])

  require Logger

  @impl true
  def join("photo:upload", %{"files" => files}, socket) do
    Logger.info("[WS]: photo upload join")

    {
      :ok,
      socket
      |> assign(:files, files)
    }
  end

  @impl true
  def handle_out(
        "image_processed" = event,
        %{filename: filename} = msg,
        %Phoenix.Socket{topic: "photo:upload"} = socket
      ) do
    # Logger.debug("Intercepted event image_processed")

    new_socket =
      if filename in socket.assigns.files do
        # Logger.debug("Received image processed and matched filename. Sending websocket msg",
        #   filename: filename
        # )

        push(socket, event, msg)

        IO.inspect(socket.assigns.files, label: "[MAMUT]: Files before")
        new_files = socket.assigns.files |> Enum.filter(&(&1 != filename))
        IO.inspect(new_files, label: "[MAMUT]: Files after")

        socket
        |> assign(:files, new_files)
      else
        socket
      end

    if new_socket.assigns.files == [] do
      # Logger.debug("No more image filenames for this socket. Disconnecting")

      push(new_socket, "phx_leave", %{})
    end

    {:noreply, new_socket}
  end

  def handle_out(ev, msg, socket) do
    # Logger.debug("Fallback branch for outgoing events")
    push(socket, ev, msg)

    {:noreply, socket}
  end
end

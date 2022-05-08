defmodule PhoenixSvelteAdminlte.Helpers.MsgHelpers do
  use GenServer

  @timeout 500

  def debounce(key, timeout \\ @timeout) do
    GenServer.cast(__MODULE__, {:debounce, self(), key, timeout})
  end

  def window(id, item, timeout) do
    GenServer.cast(__MODULE__, {:window, self(), id, item, timeout})
  end

  # SERVER

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:window, pid, id, item, timeout}, state) do
    key = {pid, id}
    state_key = {:window, key}

    new_state =
      case state[state_key] do
        nil ->
          Process.send_after(self(), {:window_timeout, key}, timeout)
          Map.put(state, state_key, [item])

        items ->
          Map.put(state, state_key, [item | items])
      end

    {:noreply, new_state}
  end

  def handle_cast({:debounce, pid, event, timeout}, state) do
    key = {pid, event}
    state_key = {:debounce, key}

    case state[state_key] do
      nil ->
        timer = Process.send_after(self(), {:debounce_hit, key}, timeout)
        state = Map.put(state, state_key, timer)
        {:noreply, state}

      timer ->
        Process.cancel_timer(timer)
        timer = Process.send_after(self(), {:debounce_hit, key}, timeout)
        state = Map.put(state, state_key, timer)
        {:noreply, state}
    end
  end

  # inner handlings

  def handle_info({:debounce_hit, {pid, event} = key}, state) do
    state = Map.delete(state, {:debounce, key})
    send(pid, {:debounced, event})
    {:noreply, state}
  end

  def handle_info({:window_timeout, {pid, id} = key}, state) do
    {items, new_state} = Map.pop(state, {:window, key})

    send(pid, {id, items})

    {:noreply, new_state}
  end
end

defmodule RgliveWeb.ListLive do
  use RgliveWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, subreddits: [], results: [], loading: false)}
  end

  def handle_event("search", %{"subreddits" => subreddits}, socket) do
    subreddits_array =
      String.split(subreddits, ",", trim: true)
      |> Enum.map(fn s -> String.trim(s) end)

    send(self(), :perform_search)
    socket = update(socket, :subreddits, &(&1 ++ subreddits_array))
    {:noreply, assign(socket, loading: true)}
  end

  def handle_event("clear", _args, socket) do
    socket = assign(socket, subreddits: [], results: [], loading: false)
    {:noreply, socket}
  end

  def handle_info(:perform_search, socket) do
    results = Rglive.Reddit.get_reddit_feed(socket.assigns.subreddits)
    IO.inspect(results)

    socket =
      assign(socket,
        results: results,
        loading: false
      )

    {:noreply, socket}
  end
end

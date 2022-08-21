defmodule SummerUniWeb.Live.IndexLive do
  use SummerUniWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_new(:posts, fn _ ->
        SummerUni.Posts.list_post()
      end) 

    {:ok, socket}
  end

  @impl true
  def handle_event("like_post", %{"id" => id}, %{assigns: %{user: user}} = socket) do
    IO.inspect("I(user:#{user.id}) just clicked like, i would like to like post with id #{id}")
    {:noreply, socket}
  end
end

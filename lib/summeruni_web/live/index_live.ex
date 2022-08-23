defmodule SummerUniWeb.Live.IndexLive do
  use SummerUniWeb, :live_view
  alias SummerUni.Posts
  alias SummerUni.Posts.Post

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_new(:posts, fn _ ->
       list_post()
     end)}
  end

  @impl true
  def handle_event("like_post", %{"id" => id}, %{assigns: %{user: user}} = socket) do
    IO.inspect("I(user:#{user.id}) just clicked like, i would like to like post with id #{id}")
    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Posts.get_post!(id)
    {:ok, _} = Posts.delete_post(post)

    {:noreply, assign(socket, :posts, list_post())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Posts.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Post")
    |> assign(:post, nil)
  end

  defp list_post do
    Posts.list_post()
  end
end

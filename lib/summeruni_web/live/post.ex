defmodule SummerUniWeb.PostComponent do
  @moduledoc """
  Renders a single post with author
  """
  use SummerUniWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="p-3 bg-white rounded-lg shadow flex flex-col gap-3 divide-y">
      <div class="rounded-full h-16 w-16 bg-gray-400 grid items-center -translate-x-6 -translate-y-6">
        <span class="text-center font-bold text-white">
          <%= @post.author.email |> String.slice(0..1) %>
        </span>
      </div>
      <%= @post.text %>
      <div class="text-gray text-sm italic self-end"><%= @post.inserted_at %></div>

      <section class="flex flex-row justify-between">
        <p class="font bold">
          Likes: <%= @post.likes %>
        </p>
        <button phx-click="like_post" phx-value-id={@post.id} class="bg-white m-2 p-2 border-none">
          <SummerUniWeb.Icons.ThumbsUp.icon />
        </button>
      </section>
    </div>
    """
  end
end

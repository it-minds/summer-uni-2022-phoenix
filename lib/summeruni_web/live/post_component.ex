defmodule SummerUniWeb.PostComponent do
  @moduledoc """
  Renders a single post with author
  """
  use SummerUniWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="p-3 bg-white rounded-lg shadow flex flex-col gap-3">
      <div class="flex flex-row gap-3">
        <div class="rounded-full h-16 w-16 bg-gray-400 grid items-center -translate-x-6 -translate-y-6">
          <span class="text-center font-bold text-white">
            <%= @post.author.email |> String.slice(0..1) %>
          </span>
        </div>
        <span class="text-center font-bold">
          <%= @post.author.email |> String.split("@") |> Enum.at(0) %>
        </span>
      </div>
      <%= @post.text %>

      <div class="h-[1px] bg-black/40 mt-2" />
      <section class="flex flex-row justify-between">
        <span class="font bold self-center">
          Likes: <%= @post.likes %>
        </span>
        <button phx-click="like_post" phx-value-id={@post.id} class="bg-white m-2 p-2 border-none">
          <SummerUniWeb.Icons.ThumbsUp.icon />
        </button>
      </section>
      <div class="text-gray text-xs italic self-end"><%= @post.inserted_at %></div>
    </div>
    """
  end
end

---
marp: true
author: Simon Bundgaard-Egeberg
title: Phoenix LiveView
header: Elixir Phoenix
---

![width:100%](phoenix.png) <!-- Setting width to 200px -->

# What is Elixir, and what is it to Phoenix?

- Functional
- Dynamically typed
- Extreme pattern matching potential
- Makes it easy to have fault tolerence and error recovery

---

# When live meets default

- Phoenix's core is a PubSub model
- Makes it easy to implement channels to pass messages
- Phoenix LiveView takes the PubSub model to the extreme
  - Most UI changes are websocket messages
  - State is on server
  - Can serve millions of users on a single server instance

---

# Lets go

_index_live.ex_

```elixir
defmodule SummerUniWeb.Live.IndexLive do
  use SummerUniWeb, :live_view
  alias SummerUni.Posts
  alias SummerUni.Posts.Post

  @impl true
  def mount(_params, _session, socket) do

    {:ok, socket
      |> assign_new(:posts, fn _ ->
        SummerUni.Posts.list_post()
      end)}
  end
end
```

---

_index_live.html.heex_

```
<%= if @live_action in [:new, :edit] do %>
  <.modal return_to={Routes.index_path(@socket, :index)}>
    <.live_component
      module={SummerUniWeb.PostLive.FormComponent}
      id={@post.id || :new}
      title={@page_title}
      action={@live_action}
      post={@post}
      return_to={Routes.index_path(@socket, :index)}
      user={@user}
    />
  </.modal>
<% end %>

<%= link("New twixt",
  to: Routes.index_path(@socket, :new),
  class: "mb-12 bg-blue-600 rounded text-white px-3 py-2 hover:bg-blue-300 self-end"
) %>

<div class="flex flex-col gap-8">
  <%= for post <- @posts do %>
    <.live_component module={SummerUniWeb.PostComponent} post={post} id={post.id} />
  <% end %>
</div>

```

---

## Making things live

- Subscribe to a topic
- Broadcast evens on said topic
- recieve events in liveviews

---

_lib/summeruni/posts.ex_

```elixir
@topic "posts"

def subscribe do
    Phoenix.PubSub.subscribe(PubSub, @topic)
end

def broadcast(data, event) do
    Phoenix.PubSub.broadcast!(PubSub, @topic, {event, data})
    data
end
```

---

# Tasks

---

## Add like functionality

- Make a post likeable
- Make a post likeable only once

---

## Add edit functionality

This functionality is already somewhat created it create new post.
It has something to do with `Route.index_path(@socket, ???)`.
if you find _post/index.ex_ you can find some inspiration.

- Find the `<.link >` tag that is the new button
- Figure out what edit should be?
- Maybe only allow owner to edit?

---

## Make it live

- Subscribe to updates
- Handle the updates
- ???
- profit

_hint: you can open two browsers to check liveness_

When subscribed the event will be `{SummerUni.Posts, [:post, :create], post}`

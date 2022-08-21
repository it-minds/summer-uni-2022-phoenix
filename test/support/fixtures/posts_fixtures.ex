defmodule SummerUni.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SummerUni.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}, user \\ nil) do
    user = if is_nil(user), do: SummerUni.AccoutsFixtures.user_fixture(), else: user

    {:ok, post} =
      attrs
      |> Enum.into(%{
        likes: 42,
        text: "some text"
      })
      |> SummerUni.Posts.create_post(user)

    post
  end
end

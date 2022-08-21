defmodule SummerUni.PostsTest do
  use SummerUni.DataCase, async: true

  alias SummerUni.Posts

  describe "post" do
    alias SummerUni.Posts.Post

    import SummerUni.PostsFixtures

    @invalid_attrs %{likes: nil, text: nil}

    test "list_post/0 returns all post" do
      post = post_fixture()
      assert Posts.list_post() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{likes: 42, text: "some text"}
      user = SummerUni.AccoutsFixtures.user_fixture()

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs, user)
      assert post.likes == 42
      assert post.text == "some text"
    end

    test "create_post/1 with invalid data returns error changeset" do
      user = SummerUni.AccoutsFixtures.user_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs, user)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{likes: 43, text: "some updated text"}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.likes == 43
      assert post.text == "some updated text"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post.text == Posts.get_post!(post.id).text
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end

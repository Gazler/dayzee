defmodule Dayzee.BlogTest do
  use Dayzee.DataCase

  alias Dayzee.Blog

  describe "posts" do
    alias Dayzee.Blog.Post

    import Dayzee.BlogFixtures

    @invalid_attrs %{name: nil, counter: nil, body: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{name: "some name", counter: 42, body: "some body"}

      assert {:ok, %Post{} = post} = Blog.create_post(valid_attrs)
      assert post.name == "some name"
      assert post.counter == 42
      assert post.body == "some body"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{name: "some updated name", counter: 43, body: "some updated body"}

      assert {:ok, %Post{} = post} = Blog.update_post(post, update_attrs)
      assert post.name == "some updated name"
      assert post.counter == 43
      assert post.body == "some updated body"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end

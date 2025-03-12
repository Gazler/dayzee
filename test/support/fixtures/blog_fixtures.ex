defmodule Dayzee.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dayzee.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        counter: 42,
        name: "some name"
      })
      |> Dayzee.Blog.create_post()

    post
  end
end

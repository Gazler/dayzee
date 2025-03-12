defmodule DayzeeWeb.PostLive.Index do
  use DayzeeWeb, :live_view

  alias Dayzee.Blog

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      Listing Posts
      <:actions>
        <.link class="btn" navigate={~p"/posts/new"}>
          New Post
        </.link>
      </:actions>
    </.header>

    <.table
      id="posts"
      rows={@streams.posts}
      row_click={fn {_id, post} -> JS.navigate(~p"/posts/#{post}") end}
    >
      <:col :let={{_id, post}} label="Name">{post.name}</:col>
      <:col :let={{_id, post}} label="Body">{post.body}</:col>
      <:col :let={{_id, post}} label="Counter">{post.counter}</:col>
      <:action :let={{_id, post}}>
        <div class="sr-only">
          <.link navigate={~p"/posts/#{post}"}>Show</.link>
        </div>
        <.link navigate={~p"/posts/#{post}/edit"}>Edit</.link>
      </:action>
      <:action :let={{id, post}}>
        <.link
          phx-click={JS.push("delete", value: %{id: post.id}) |> hide("##{id}")}
          data-confirm="Are you sure?"
        >
          Delete
        </.link>
      </:action>
    </.table>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Posts")
     |> stream(:posts, Blog.list_posts())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Blog.get_post!(id)
    {:ok, _} = Blog.delete_post(post)

    {:noreply, stream_delete(socket, :posts, post)}
  end
end

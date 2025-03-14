defmodule Dayzee.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :name, :string
    field :body, :string
    field :counter, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :body, :counter])
    |> validate_required([:name, :body, :counter])
    |> add_error(:name, "not permitted")
  end
end

defmodule Dayzee.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :name, :string
      add :body, :text
      add :counter, :integer

      timestamps(type: :utc_datetime)
    end
  end
end

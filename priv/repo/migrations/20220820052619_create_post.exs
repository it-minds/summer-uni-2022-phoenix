defmodule SummerUni.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :text, :string
      add :likes, :integer
      add :author_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:post, [:author_id])
  end
end

defmodule SummerUni.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post" do
    field :likes, :integer
    field :text, :string
    belongs_to :author, SummerUni.Accouts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:text, :likes])
    |> validate_required([:text, :likes])
  end
end

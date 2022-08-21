# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SummerUni.Repo.insert!(%SummerUni.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SummerUni.{Accouts, Posts}

users =
  ~w(Rosalyn Blake Sasha Phyllis Clarissa Trevino Felicia Cora Melissa Violet Brown Lessie Taylor Sherri Margeret Kristy Noemi Trisha Hendrix Mann)

inserted_users =
  users
  |> Enum.map(fn user ->
    {:ok, user} = Accouts.register_user(%{email: "#{user}@email.com", password: "password1234"})
    user
  end)

inserted_users
|> Enum.each(fn user ->
  Posts.create_post(%{text: "I am the best, fuck the rest", likes: 0}, user)
end)

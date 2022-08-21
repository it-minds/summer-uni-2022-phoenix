defmodule SummerUniWeb.UserRegistrationController do
  use SummerUniWeb, :controller

  alias SummerUni.Accouts
  alias SummerUni.Accouts.User
  alias SummerUniWeb.UserAuth

  def new(conn, _params) do
    changeset = Accouts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accouts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accouts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

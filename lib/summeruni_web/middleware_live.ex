defmodule SummerUniWeb.MiddlewareLive do
  alias Phoenix.LiveView

  def on_mount(:authed, _params, %{"user_token" => token} = _session, socket) do
    user = SummerUni.Accouts.get_user_by_session_token(token)

    {:cont, socket |> LiveView.assign(user: user)}
  end
end

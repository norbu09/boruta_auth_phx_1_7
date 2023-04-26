defmodule BorutaExampleWeb.Plugs.Authorization do
  import Plug.Conn

  use BorutaExampleWeb, :controller

  alias Boruta.Oauth.Authorization
  alias Boruta.Oauth.Scope
  alias BorutaExample.Accounts

  def require_authenticated(conn, _opts) do
    with [authorization_header] <- get_req_header(conn, "authorization"),
         [_authorization_header, bearer] <- Regex.run(~r/[B|b]earer (.+)/, authorization_header),
         {:ok, token} <- Authorization.AccessToken.authorize(value: bearer) do
      conn
      |> assign(:current_token, token)
      |> assign(:current_user, Accounts.get_user!(token.sub))
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> put_view(BorutaExampleWeb.ErrorJSON)
        |> render("401.json")
        |> halt()
    end
  end

  def authorize(conn, [_h | _t] = required_scopes) do
    current_scopes = Scope.split(conn.assigns[:current_token].scope)

    case Enum.empty?(required_scopes -- current_scopes) do
      true ->
        conn

      false ->
        conn
        |> put_status(:forbidden)
        |> put_view(BorutaExampleWeb.ErrorJSON)
        |> render("403.json")
        |> halt()
    end
  end
end

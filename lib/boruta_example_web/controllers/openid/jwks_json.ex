defmodule BorutaExampleWeb.Openid.JwqsJson do

  def render("jwks.json", %{jwk_keys: jwk_keys}) do
    %{keys: jwk_keys}
  end

end


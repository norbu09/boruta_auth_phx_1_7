defmodule BorutaExampleWeb.Openid.UserinfoJson do

  alias Boruta.Openid.UserinfoResponse

  def render("userinfo.json", %{response: response}) do
    UserinfoResponse.payload(response)
  end
end



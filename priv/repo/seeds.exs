# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
id = SecureRandom.uuid()
secret = SecureRandom.hex(64)

Boruta.Ecto.Admin.create_client(%{
  id: id, # OAuth client_id
  secret: secret, # OAuth client_secret
  name: "A client", # Display name
  access_token_ttl: 60 * 60 * 24, # one day
  authorization_code_ttl: 60, # one minute
  refresh_token_ttl: 60 * 60 * 24 * 30, # one month
  id_token_ttl: 60 * 60 * 24, # one day
  id_token_signature_alg: "RS256", # ID token signature algorithm, defaults to "RS512"
  userinfo_signed_response_alg: "RS256", # userinfo signature algorithm, defaults to nil (no signature)
  redirect_uris: ["http://redirect.uri"], # OAuth client redirect_uris
  authorize_scope: true, # take following authorized_scopes into account (skip public scopes)
  authorized_scopes: [%{name: "a:scope"}], # scopes that are authorized using this client
  supported_grant_types: [ # client supported grant types
    "client_credentials",
    "password",
    "authorization_code",
    "refresh_token",
    "implicit",
    "revoke",
    "introspect"
  ],
  pkce: false, # PKCE enabled
  public_refresh_token: false, # do not require client_secret for refreshing tokens
  public_revoke: false, # do not require client_secret for revoking tokens
  confidential: true, # see OAuth 2.0 confidentiality (requires client secret for some flows)
  token_endpont_auth_methods: [ # activable client authentication methods
    "client_secret_basic",
    "client_secret_post",
    "client_secret_jwt",
    "private_key_jwt"
  ],
}) |> IO.inspect

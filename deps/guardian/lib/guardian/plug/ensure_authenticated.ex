if Code.ensure_loaded?(Plug) do
  defmodule Guardian.Plug.EnsureAuthenticated do
    @moduledoc """
    This plug ensures that a valid token was provided and has been verified on the request.

    If one is not found, the `auth_error` will be called with `:unauthenticated`

    This, like all other Guardian plugs, requires a Guardian pipeline to be setup.
    It requires an implementation module, an error handler and a key.

    These can be set either:

    1. Upstream on the connection with `plug Guardian.Pipeline`
    2. Upstream on the connection with `Guardian.Pipeline.{put_module, put_error_handler, put_key}`
    3. Inline with an option of `:module`, `:error_handler`, `:key`

    Options:

    * `claims` - The literal claims to check to ensure that a token is valid
    * `key` - The location to find the information in the connection. Defaults to: `default`

    ## Example

    ```elixir
    # setup the upstream pipeline
    plug Guardian.Plug.EnsureAuthenticated, claims: %{"typ" => "access"}
    plug Guardian.Plug.EnsureAuthenticated, key: :secret
    ```
    """
    alias Guardian.Plug, as: GPlug
    alias Guardian.Plug.Pipeline
    alias Guardian.Token.Verify

    import Plug.Conn

    @doc false
    def init(opts), do: opts

    @doc false
    def call(conn, opts) do
      conn
      |> GPlug.current_token(opts)
      |> verify(conn, opts)
      |> respond()
    end

    defp verify(nil, conn, opts), do: {{:error, :unauthenticated}, conn, opts}

    defp verify(_token, conn, opts) do
      result =
        conn
        |> GPlug.current_claims(opts)
        |> verify_claims(opts)

      {result, conn, opts}
    end

    def respond({{:ok, _}, conn, _opts}), do: conn

    def respond({{:error, reason}, conn, opts}) do
      conn
      |> Pipeline.fetch_error_handler!(opts)
      |> apply(:auth_error, [conn, {:unauthenticated, reason}, opts])
      |> halt()
    end

    defp verify_claims(claims, opts) do
      to_check = Keyword.get(opts, :claims)
      Verify.verify_literal_claims(claims, to_check, opts)
    end
  end
end
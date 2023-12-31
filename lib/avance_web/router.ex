defmodule AvanceWeb.Router do
  @moduledoc false
  use AvanceWeb, :router

  import AvanceWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AvanceWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :unauthenticated_layout do
    plug :put_root_layout, html: {AvanceWeb.Layouts, :unauthenticated}
  end

  pipeline :auth do
    plug(Ueberauth)
  end

  pipeline :api_spec do
    plug OpenApiSpex.Plug.PutApiSpec, module: AvanceWeb.ApiSpec
  end

  scope "/api" do
    pipe_through [:api, :api_spec]
    get "/specs", OpenApiSpex.Plug.RenderSpec, []
  end

  scope "/api/i1", AvanceWeb.Controllers.Api do
    pipe_through([:api])
  end

  scope "/" do
    # TODO: Make sure you want to have this open in production
    pipe_through([:browser])
    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/api/specs"
  end

  scope "/", AvanceWeb do
    pipe_through([:browser, :unauthenticated_layout, :redirect_if_user_is_authenticated])

    get("/sign-in", Controllers.SignInController, :new)
  end

  ## OAuth routes
  scope "/oauth", AvanceWeb do
    pipe_through([:browser, :auth])
    get("/:provider", Controllers.OAuthController, :request)
    get("/:provider/callback", Controllers.OAuthController, :callback)
  end

  scope "/", AvanceWeb do
    pipe_through :browser

    live_session :authenticated, on_mount: [{AvanceWeb.UserAuth, :ensure_authenticated}] do
      live("/", Live.HomeLive, :show)
    end
  end

  scope "/", AvanceWeb do
    pipe_through [:browser]

    delete "/users/log-out", UserSessionController, :delete
  end

  ## Authentication routes
  scope "/", AvanceWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{AvanceWeb.UserAuth, :ensure_authenticated}] do
      live "/profile", ProfileLive.Show, :show
      live "/profile/dev-token", ProfileLive.Show, :token
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:avance, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AvanceWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

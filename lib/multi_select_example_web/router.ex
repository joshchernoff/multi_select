defmodule MultiSelectExampleWeb.Router do
  use MultiSelectExampleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MultiSelectExampleWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MultiSelectExampleWeb do
    pipe_through :browser

    live "/things", ThingLive.Index, :index
    live "/things/new", ThingLive.Index, :new
    live "/things/:id/edit", ThingLive.Index, :edit

    live "/things/:id", ThingLive.Show, :show
    live "/things/:id/show/edit", ThingLive.Show, :edit

    live "/", ExampleLive.Index, :index
    live "/new", ExampleLive.Index, :new
    live "/:id/edit", ExampleLive.Index, :edit

    live "/:id", ExampleLive.Show, :show
    live "/:id/show/edit", ExampleLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", MultiSelectExampleWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:multi_select_example, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MultiSelectExampleWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

defmodule PhoenixSvelteAdminlteWeb.Router do
  use PhoenixSvelteAdminlteWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {PhoenixSvelteAdminlteWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", PhoenixSvelteAdminlteWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/data", PhoenixSvelteAdminlteWeb do
    pipe_through(:browser)

    get("/tree", DemoDataController, :tree_inital_data)
  end

  scope "/api", PhoenixSvelteAdminlteWeb do
    pipe_through :api

    scope "/image" do
      get "/", PhotosApiController, :get
      post "/process", PhotosApiController, :process
      delete "/:uuid", PhotosApiController, :delete
    end

    scope "/jobs" do
      get "/", JobsApiController, :get_jobs
      delete "/:id", JobsApiController, :delete_job
    end
  end

  scope "/assets", PhoenixSvelteAdminlteWeb do
    pipe_through :api

    get "/img/:uuid", ImageApiController, :original
    get "/img/:uuid/dims", ImageApiController, :dimensions
    get "/img/:uuid/t/:thumbnail_size", ImageApiController, :thumbnail
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixSvelteAdminlteWeb do
  #   pipe_through :api
  # end
end

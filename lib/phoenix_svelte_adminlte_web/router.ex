defmodule PhoenixSvelteAdminlteWeb.Router do
  use PhoenixSvelteAdminlteWeb, :router

  require KeenAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhoenixSvelteAdminlteWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authentication do
    plug :fetch_session
    plug :put_root_layout, {KeenAuthDemoWeb.LayoutView, :root}
  end

  pipeline :authorization do
    plug :fetch_session
    plug KeenAuth.Plug.FetchUser
  end

  scope "/", PhoenixSvelteAdminlteWeb do
    pipe_through :browser

    get "/", PageController, :index

    scope "/admin" do
      get "/secret", AdminController, :secret
    end
  end

  scope "/auth" do
    pipe_through :authentication

    KeenAuth.authentication_routes()
  end

  scope "/data", PhoenixSvelteAdminlteWeb do
    pipe_through :browser

    get "/tree", DemoDataController, :tree_inital_data
  end

  scope "/api", PhoenixSvelteAdminlteWeb do
    pipe_through :api

    scope "/image" do
      get "/", PhotosApiController, :get
      post "/process", PhotosApiController, :process
    end
  end

  scope "/assets", PhoenixSvelteAdminlteWeb do
    pipe_through :api

    get "/img/:uuid", ImageApiController, :original
    get "/img/:uuid/dims", ImageApiController, :dimensions
    get "/img/:uuid/t/:thumbnail_size", ImageApiController, :thumbnail
  end
end

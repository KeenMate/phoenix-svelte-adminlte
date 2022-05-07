defmodule PhoenixSvelteAdminlte.Image.Manager do
  require Logger
  import PhoenixSvelteAdminlte.Image.Helpers
  alias Pluto.Image.ImageModel

  def all_images() do
    {:ok,
     [
       %ImageModel{
         gallery_photo_id: 1,
         id: 2,
         uuid: "2",
         width: 1920,
         height: 1080,
         size: 132_456
       },
       %ImageModel{
         gallery_photo_id: 1,
         id: 3,
         uuid: "3",
         width: 1920,
         height: 1080,
         size: 132_456
       },
       %ImageModel{
         gallery_photo_id: 1,
         id: 4,
         uuid: "4",
         width: 1920,
         height: 1080,
         size: 132_456
       },
       %ImageModel{
         gallery_photo_id: 1,
         id: 5,
         uuid: "5",
         width: 1920,
         height: 1080,
         size: 132_456
       },
       %ImageModel{
         gallery_photo_id: 1,
         id: 6,
         uuid: "6",
         width: 1920,
         height: 1080,
         size: 132_456
       },
       %ImageModel{
         gallery_photo_id: 1,
         id: 7,
         uuid: "7",
         width: 1920,
         height: 1080,
         size: 132_456
       }
     ]}
  end
end

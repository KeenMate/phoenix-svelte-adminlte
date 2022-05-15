# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.DbContext do
  @moduledoc """
  This module contains functions for calling DB's stored procedures.

  Functions inside this module require as a first argument a pid. It is the pid of Postgrex driver process.
  """

  require Logger

  import Elixir.PhoenixSvelteAdminlte.Repo, only: [query: 2]

  @spec add_gallery_photos(integer(), any()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.AddGalleryPhotosItem.t()]}
  def add_gallery_photos(gallery_id, photo_ids) do
    Logger.debug("Calling stored procedure", procedure: "add_gallery_photos")

    query(
      "select * from public.add_gallery_photos($1, $2)",
      [gallery_id, photo_ids]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.AddGalleryPhotosParser.parse_add_gallery_photos_result()
  end

  @spec add_job(binary(), binary(), integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.AddJobItem.t()]}
  def add_job(name, cron, script_id) do
    Logger.debug("Calling stored procedure", procedure: "add_job")

    query(
      "select * from public.add_job($1, $2, $3)",
      [name, cron, script_id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.AddJobParser.parse_add_job_result()
  end

  @spec add_journal_msg(binary(), integer(), binary(), binary(), integer(), any(), integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.AddJournalMsgItem.t()]}
  def add_journal_msg(created_by, user_id, msg, data_group, data_object_id, payload, event_id) do
    Logger.debug("Calling stored procedure", procedure: "add_journal_msg")

    query(
      "select * from public.add_journal_msg($1, $2, $3, $4, $5, $6, $7)",
      [created_by, user_id, msg, data_group, data_object_id, payload, event_id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.AddJournalMsgParser.parse_add_journal_msg_result()
  end

  @spec add_journal_msg_jsonb(
          binary(),
          integer(),
          binary(),
          binary(),
          integer(),
          any(),
          integer()
        ) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.AddJournalMsgJsonbItem.t()]}
  def add_journal_msg_jsonb(
        created_by,
        user_id,
        msg,
        data_group,
        data_object_id,
        payload,
        event_id
      ) do
    Logger.debug("Calling stored procedure", procedure: "add_journal_msg_jsonb")

    query(
      "select * from public.add_journal_msg_jsonb($1, $2, $3, $4, $5, $6, $7)",
      [created_by, user_id, msg, data_group, data_object_id, payload, event_id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.AddJournalMsgJsonbParser.parse_add_journal_msg_jsonb_result()
  end

  @spec add_photo(binary(), binary(), integer(), integer(), integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.AddPhotoItem.t()]}
  def add_photo(code, original_filename, width, height, file_size) do
    Logger.debug("Calling stored procedure", procedure: "add_photo")

    query(
      "select * from public.add_photo($1, $2, $3, $4, $5)",
      [code, original_filename, width, height, file_size]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.AddPhotoParser.parse_add_photo_result()
  end

  @spec add_script(binary(), binary()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.AddScriptItem.t()]}
  def add_script(name, content) do
    Logger.debug("Calling stored procedure", procedure: "add_script")

    query(
      "select * from public.add_script($1, $2)",
      [name, content]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.AddScriptParser.parse_add_script_result()
  end

  @spec delete_job(binary()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.DeleteJobItem.t()]}
  def delete_job(name) do
    Logger.debug("Calling stored procedure", procedure: "delete_job")

    query(
      "select * from public.delete_job($1)",
      [name]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.DeleteJobParser.parse_delete_job_result()
  end

  @spec delete_script(integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.DeleteScriptItem.t()]}
  def delete_script(script_id) do
    Logger.debug("Calling stored procedure", procedure: "delete_script")

    query(
      "select * from public.delete_script($1)",
      [script_id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.DeleteScriptParser.parse_delete_script_result()
  end

  @spec get_all_galleries() ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetAllGalleriesItem.t()]}
  def get_all_galleries() do
    Logger.debug("Calling stored procedure", procedure: "get_all_galleries")

    query(
      "select * from public.get_all_galleries()",
      []
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetAllGalleriesParser.parse_get_all_galleries_result()
  end

  @spec get_all_photos() ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetAllPhotosItem.t()]}
  def get_all_photos() do
    Logger.debug("Calling stored procedure", procedure: "get_all_photos")

    query(
      "select * from public.get_all_photos()",
      []
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetAllPhotosParser.parse_get_all_photos_result()
  end

  @spec get_gallery(integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetGalleryItem.t()]}
  def get_gallery(gallery_id) do
    Logger.debug("Calling stored procedure", procedure: "get_gallery")

    query(
      "select * from public.get_gallery($1)",
      [gallery_id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetGalleryParser.parse_get_gallery_result()
  end

  @spec get_gallery_photos(binary(), integer()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetGalleryPhotosItem.t()]}
  def get_gallery_photos(code, gallery_id) do
    Logger.debug("Calling stored procedure", procedure: "get_gallery_photos")

    query(
      "select * from public.get_gallery_photos($1, $2)",
      [code, gallery_id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetGalleryPhotosParser.parse_get_gallery_photos_result()
  end

  @spec get_jobs() ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetJobsItem.t()]}
  def get_jobs() do
    Logger.debug("Calling stored procedure", procedure: "get_jobs")

    query(
      "select * from public.get_jobs()",
      []
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetJobsParser.parse_get_jobs_result()
  end

  @spec get_journal_msgs(integer(), DateTime.t(), DateTime.t()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetJournalMsgsItem.t()]}
  def get_journal_msgs(user_id, from, to) do
    Logger.debug("Calling stored procedure", procedure: "get_journal_msgs")

    query(
      "select * from public.get_journal_msgs($1, $2, $3)",
      [user_id, from, to]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetJournalMsgsParser.parse_get_journal_msgs_result()
  end

  @spec get_journal_payload(integer(), integer()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetJournalPayloadItem.t()]}
  def get_journal_payload(user_id, journal_id) do
    Logger.debug("Calling stored procedure", procedure: "get_journal_payload")

    query(
      "select * from public.get_journal_payload($1, $2)",
      [user_id, journal_id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetJournalPayloadParser.parse_get_journal_payload_result()
  end

  @spec get_random_photo(binary()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetRandomPhotoItem.t()]}
  def get_random_photo(code) do
    Logger.debug("Calling stored procedure", procedure: "get_random_photo")

    query(
      "select * from public.get_random_photo($1)",
      [code]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetRandomPhotoParser.parse_get_random_photo_result()
  end

  @spec get_script(integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetScriptItem.t()]}
  def get_script(script_id) do
    Logger.debug("Calling stored procedure", procedure: "get_script")

    query(
      "select * from public.get_script($1)",
      [script_id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetScriptParser.parse_get_script_result()
  end

  @spec get_top_photos(integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetTopPhotosItem.t()]}
  def get_top_photos(how_many) do
    Logger.debug("Calling stored procedure", procedure: "get_top_photos")

    query(
      "select * from public.get_top_photos($1)",
      [how_many]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetTopPhotosParser.parse_get_top_photos_result()
  end

  @spec move_gallery_photo(any(), integer(), integer(), any()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.MoveGalleryPhotoItem.t()]}
  def move_gallery_photo(gallery_photo_ids, target_id, gallery_id, position) do
    Logger.debug("Calling stored procedure", procedure: "move_gallery_photo")

    query(
      "select * from public.move_gallery_photo($1, $2, $3, $4)",
      [gallery_photo_ids, target_id, gallery_id, position]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.MoveGalleryPhotoParser.parse_move_gallery_photo_result()
  end

  @spec remove_gallery(integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.RemoveGalleryItem.t()]}
  def remove_gallery(gallery_id) do
    Logger.debug("Calling stored procedure", procedure: "remove_gallery")

    query(
      "select * from public.remove_gallery($1)",
      [gallery_id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.RemoveGalleryParser.parse_remove_gallery_result()
  end

  @spec remove_gallery_photos(integer(), any()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.RemoveGalleryPhotosItem.t()]}
  def remove_gallery_photos(gallery_id, gallery_photo_ids) do
    Logger.debug("Calling stored procedure", procedure: "remove_gallery_photos")

    query(
      "select * from public.remove_gallery_photos($1, $2)",
      [gallery_id, gallery_photo_ids]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.RemoveGalleryPhotosParser.parse_remove_gallery_photos_result()
  end

  @spec remove_photo(binary()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.RemovePhotoItem.t()]}
  def remove_photo(code) do
    Logger.debug("Calling stored procedure", procedure: "remove_photo")

    query(
      "select * from public.remove_photo($1)",
      [code]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.RemovePhotoParser.parse_remove_photo_result()
  end

  @spec save_gallery(binary(), binary(), binary(), integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.SaveGalleryItem.t()]}
  def save_gallery(code, title_cs, title_en, gallery_id) do
    Logger.debug("Calling stored procedure", procedure: "save_gallery")

    query(
      "select * from public.save_gallery($1, $2, $3, $4)",
      [code, title_cs, title_en, gallery_id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.SaveGalleryParser.parse_save_gallery_result()
  end

  @spec trg_generate_code_from_title() :: {:error, any()} | {:ok, [any()]}
  def trg_generate_code_from_title() do
    Logger.debug("Calling stored procedure", procedure: "trg_generate_code_from_title")

    query(
      "select * from public.trg_generate_code_from_title()",
      []
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.TrgGenerateCodeFromTitleParser.parse_trg_generate_code_from_title_result()
  end
end
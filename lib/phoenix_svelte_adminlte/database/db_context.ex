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

  @spec add_job_run(integer(), DateTime.t()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.AddJobRunItem.t()]}
  def add_job_run(job_id, start_time) do
    Logger.debug("Calling stored procedure", procedure: "add_job_run")

    query(
      "select * from public.add_job_run($1, $2)",
      [job_id, start_time]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.AddJobRunParser.parse_add_job_run_result()
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

  @spec add_translation(binary(), integer(), binary(), binary(), binary(), integer(), binary()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.AddTranslationItem.t()]}
  def add_translation(
        created_by,
        user_id,
        language_code,
        data_group,
        data_object_code,
        data_object_id,
        value
      ) do
    Logger.debug("Calling stored procedure", procedure: "add_translation")

    query(
      "select * from public.add_translation($1, $2, $3, $4, $5, $6, $7)",
      [created_by, user_id, language_code, data_group, data_object_code, data_object_id, value]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.AddTranslationParser.parse_add_translation_result()
  end

  @spec complete_job_run(integer(), DateTime.t(), binary(), integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.CompleteJobRunItem.t()]}
  def complete_job_run(job_id, end_time, status, duration) do
    Logger.debug("Calling stored procedure", procedure: "complete_job_run")

    query(
      "select * from public.complete_job_run($1, $2, $3, $4)",
      [job_id, end_time, status, duration]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.CompleteJobRunParser.parse_complete_job_run_result()
  end

  @spec create_permission_by_code(binary(), integer(), binary(), binary(), boolean()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.CreatePermissionByCodeItem.t()]}
  def create_permission_by_code(created_by, user_id, title, parent_code, is_assignable) do
    Logger.debug("Calling stored procedure", procedure: "create_permission_by_code")

    query(
      "select * from public.create_permission_by_code($1, $2, $3, $4, $5)",
      [created_by, user_id, title, parent_code, is_assignable]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.CreatePermissionByCodeParser.parse_create_permission_by_code_result()
  end

  @spec create_permission_by_path(binary(), integer(), binary(), binary(), binary(), boolean()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.CreatePermissionByPathItem.t()]}
  def create_permission_by_path(
        created_by,
        user_id,
        data_node_path,
        title,
        parent_path,
        is_assignable
      ) do
    Logger.debug("Calling stored procedure", procedure: "create_permission_by_path")

    query(
      "select * from public.create_permission_by_path($1, $2, $3, $4, $5, $6)",
      [created_by, user_id, data_node_path, title, parent_path, is_assignable]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.CreatePermissionByPathParser.parse_create_permission_by_path_result()
  end

  @spec delete_job(integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.DeleteJobItem.t()]}
  def delete_job(id) do
    Logger.debug("Calling stored procedure", procedure: "delete_job")

    query(
      "select * from public.delete_job($1)",
      [id]
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

  @spec ensure_roles_and_permissions(binary(), any(), boolean(), boolean()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.EnsureRolesAndPermissionsItem.t()]}
  def ensure_roles_and_permissions(oid, provider_groups, is_manager, is_trusted_user) do
    Logger.debug("Calling stored procedure", procedure: "ensure_roles_and_permissions")

    query(
      "select * from public.ensure_roles_and_permissions($1, $2, $3, $4)",
      [oid, provider_groups, is_manager, is_trusted_user]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.EnsureRolesAndPermissionsParser.parse_ensure_roles_and_permissions_result()
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

  @spec get_job(integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetJobItem.t()]}
  def get_job(id) do
    Logger.debug("Calling stored procedure", procedure: "get_job")

    query(
      "select * from public.get_job($1)",
      [id]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetJobParser.parse_get_job_result()
  end

  @spec get_job_runs(integer(), integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetJobRunsItem.t()]}
  def get_job_runs(start, count) do
    Logger.debug("Calling stored procedure", procedure: "get_job_runs")

    query(
      "select * from public.get_job_runs($1, $2)",
      [start, count]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetJobRunsParser.parse_get_job_runs_result()
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

  @spec get_roles_and_permissions(binary()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.GetRolesAndPermissionsItem.t()]}
  def get_roles_and_permissions(oid) do
    Logger.debug("Calling stored procedure", procedure: "get_roles_and_permissions")

    query(
      "select * from public.get_roles_and_permissions($1)",
      [oid]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.GetRolesAndPermissionsParser.parse_get_roles_and_permissions_result()
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

  @spec has_permission(integer(), binary(), boolean()) :: {:error, any()} | {:ok, [boolean()]}
  def has_permission(user_id, perm_code, throw_err) do
    Logger.debug("Calling stored procedure", procedure: "has_permission")

    query(
      "select * from public.has_permission($1, $2, $3)",
      [user_id, perm_code, throw_err]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.HasPermissionParser.parse_has_permission_result()
  end

  @spec load_initial_data() :: {:error, any()} | {:ok, [integer()]}
  def load_initial_data() do
    Logger.debug("Calling stored procedure", procedure: "load_initial_data")

    query(
      "select * from public.load_initial_data()",
      []
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.LoadInitialDataParser.parse_load_initial_data_result()
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

  @spec throw_no_permission(integer(), binary()) :: {:error, any()} | {:ok, [any()]}
  def throw_no_permission(user_id, perm_code) do
    Logger.debug("Calling stored procedure", procedure: "throw_no_permission")

    query(
      "select * from public.throw_no_permission($1, $2)",
      [user_id, perm_code]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.ThrowNoPermissionParser.parse_throw_no_permission_result()
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

  @spec update_job(integer(), binary(), integer(), binary()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.UpdateJobItem.t()]}
  def update_job(job_id, name, script_id, cron) do
    Logger.debug("Calling stored procedure", procedure: "update_job")

    query(
      "select * from public.update_job($1, $2, $3, $4)",
      [job_id, name, script_id, cron]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.UpdateJobParser.parse_update_job_result()
  end

  @spec update_permission_full_code(any()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.UpdatePermissionFullCodeItem.t()]}
  def update_permission_full_code(perm_path) do
    Logger.debug("Calling stored procedure", procedure: "update_permission_full_code")

    query(
      "select * from public.update_permission_full_code($1)",
      [perm_path]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.UpdatePermissionFullCodeParser.parse_update_permission_full_code_result()
  end

  @spec update_permission_full_title(any()) ::
          {:error, any()}
          | {:ok, [PhoenixSvelteAdminlte.Database.Models.UpdatePermissionFullTitleItem.t()]}
  def update_permission_full_title(perm_path) do
    Logger.debug("Calling stored procedure", procedure: "update_permission_full_title")

    query(
      "select * from public.update_permission_full_title($1)",
      [perm_path]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.UpdatePermissionFullTitleParser.parse_update_permission_full_title_result()
  end

  @spec update_script(integer(), binary(), integer()) ::
          {:error, any()} | {:ok, [PhoenixSvelteAdminlte.Database.Models.UpdateScriptItem.t()]}
  def update_script(scipt_id, name, content) do
    Logger.debug("Calling stored procedure", procedure: "update_script")

    query(
      "select * from public.update_script($1, $2, $3)",
      [scipt_id, name, content]
    )
    |> PhoenixSvelteAdminlte.Database.Parsers.UpdateScriptParser.parse_update_script_result()
  end
end
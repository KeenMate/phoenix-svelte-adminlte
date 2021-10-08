<script>
  import { _ } from "svelte-i18n";
  import { PageHeader, BreadcrumbItem } from "svelte-adminlte";
  import UserDetail from "../controls/users/UserDetail.svelte";
  import UserList from "../controls/users/UserList.svelte";
  import UserOrders from "../controls/users/UserOrders.svelte";
  import usersChannel from "../providers/socket/usersChannel";

  let selectedUserId = null;
</script>

<PageHeader>
  <svelte:fragment>
    {$_("users.title")} <small>Twin Peaks Community</small>
  </svelte:fragment>

  <svelte:fragment slot="breadcrumbs">
    <BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
    <BreadcrumbItem active>{$_("users.title")}</BreadcrumbItem>
  </svelte:fragment>
</PageHeader>

<div class="row">
  <div class:col-12={!selectedUserId} class:col-6={selectedUserId}>
    <UserList expanded={!selectedUserId} on:edit={({ detail: userId }) => (selectedUserId = userId)} />
  </div>
  {#if selectedUserId}
    <div class="col-6">
      <UserDetail userId={selectedUserId} on:close={() => (selectedUserId = null)} />
    </div>
  {/if}
</div>

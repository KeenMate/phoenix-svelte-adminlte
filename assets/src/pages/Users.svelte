<script>
  import { _ } from "svelte-i18n";
  import { PageHeader, BreadcrumbItem } from "svelte-adminlte";
  import UserDetail from "../components/users/UserDetail.svelte";
  import UserList from "../components/users/UserList.svelte";
  import UserOrders from "../components/users/UserOrders.svelte";
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
  <div class={selectedUserId?"col-lg-6 col-md-12 order-1": "col-12 "}>
    <UserList expanded={!selectedUserId} on:edit={({ detail: userId }) => (selectedUserId = userId)} />
  </div>
  {#if selectedUserId}
    <div class="col-lg-6 col-md-12 order-0">
      <UserDetail userId={selectedUserId} on:close={() => (selectedUserId = null)} />
    </div>
  {/if}
</div>

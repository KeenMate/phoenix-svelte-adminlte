<script>
  import { onMount, setContext } from "svelte";
  import { get } from "svelte/store";
  import Router from "svelte-spa-router";
  import keymage from "keymage";

  import "./locale/i18n";
  import routes, { Routes } from "./routes";

  import currentUser from "./stores/current-user";
  import sidebarOpenState from "./stores/sidebar-open-state";
  import {
    login,
    isAuthenticated,
    userInfo,
    AzureProvider,
    ZuubrProvider,
    appMountCallback,
    logout,
  } from "./stores/authentication";

  import {
    TopNavigation,
    PageHeader,
    Sidebar,
    SidebarNavItem,
    TopNavItem,
    Loader,
    UserDropdownMenu,
    Dropdown,
    DropdownItem,
    DropdownButton,
    DropdownMenu,
  } from "svelte-adminlte";

  import MessageLog from "./controls/modals/MessageLog.svelte";
  import { initSocket } from "./providers/socket";

  function applySidebarOpenState() {
    if (!get(sidebarOpenState)) {
      document.body.classList.add("sidebar-collapse", "sidebar-mini-expand-feature");
      document.body.classList.remove("sidebar-mini-expand-feature");
    }
  }

  onMount(() => {
    // applySidebarOpenState();

    initSocket();

    keymage("ctrl-0", () => {
      console.log("opening logs");
      showLog();
    });
  });

  let loading = false;
  let showLog;

  setContext("loader", {
    setLoading: (val) => (loading = val),
  });

  onMount(appMountCallback);
</script>

<div class="wrapper">
  <TopNavigation>
    <svelte:fragment slot="left">
      <TopNavItem href="#/">Home</TopNavItem>
      <Dropdown>
        <DropdownButton>Pages</DropdownButton>

        <DropdownMenu>
          <DropdownItem href="#/list">List</DropdownItem>
        </DropdownMenu>
      </Dropdown>
    </svelte:fragment>

    <svelte:fragment slot="right">
      {#if $isAuthenticated}
        <Dropdown slot="right">
          <DropdownButton>{$userInfo.name}</DropdownButton>

          <DropdownMenu right>
            <DropdownItem on:click={() => logout()}>Log Out</DropdownItem>
          </DropdownMenu>
        </Dropdown>
      {:else}
        <Dropdown>
          <DropdownButton>Log In</DropdownButton>
          <DropdownMenu right>
            <DropdownItem on:click={() => login(AzureProvider)}>Azure</DropdownItem>
            <DropdownItem on:click={() => login(ZuubrProvider)}>Zuubr</DropdownItem>
          </DropdownMenu>
        </Dropdown>
      {/if}
    </svelte:fragment>
  </TopNavigation>

  <Sidebar>
    {#each Routes as route}
      {#if !route.hide}
        <SidebarNavItem icon={route.icon} href="#{route.route}"><p>{route.name}</p></SidebarNavItem>
      {/if}
    {/each}
  </Sidebar>

  <div class="content-wrapper">
    <!-- {#if loading}
      <Loader />
    {/if} -->
    <!-- <PageHeader /> -->
    <div class="content">
      <Router {routes} />
    </div>
  </div>

  <MessageLog bind:show={showLog} />
</div>

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
    TopNavigation,
    PageHeader,
    Sidebar,
    SidebarNavItem,
    TopNavItem,
    Loader,
    UserDropdownMenu,
  } from "svelte-adminlte";
  import { OidcContext, userInfo } from "@dopry/svelte-oidc";

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
</script>

<OidcContext
  client_id="phoenix-svelte-adminlte-local"
  issuer="https://auth.zuubr.com/auth/realms/zuubr"
  redirect_uri="http://localhost:4000"
>
  <div class="wrapper">
    <TopNavigation>
      <svelte:fragment slot="left">
        <TopNavItem href="#/">Home</TopNavItem>
      </svelte:fragment>
      <!-- <svelte:fragment slot="right">{$userInfo.name || ''}</svelte:fragment> -->
      <!-- <UserDropdownMenu displayName={$userInfo.name || 'Nepřihlášený'} slot="right" /> -->
      <TopDropdownItem
    </TopNavigation>

    <Sidebar>
      {#each Routes as route}
        {#if !route.hide}
          <SidebarNavItem icon={route.icon} href="#{route.route}">{route.name}</SidebarNavItem>
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
</OidcContext>

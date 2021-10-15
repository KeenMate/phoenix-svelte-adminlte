<script>
  import { onMount, setContext } from "svelte";
  import { get } from "svelte/store";
  import Router from "svelte-spa-router";
  import keymage from "keymage";

  import "./locale/i18n";
  import routes, { Routes } from "./routes";
  import { OidcContext, userInfo, isAuthenticated } from "@dopry/svelte-oidc";

  import currentUser from "./stores/current-user";
  import sidebarOpenState from "./stores/sidebar-open-state";
  import { setAzureProvider, setZuubrProvider, clientId, issuer } from "./stores/authentication";

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
  import LoginButton from "./controls/LoginButton.svelte";
  import LogoutButton from "./controls/LogoutButton.svelte";

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
  client_id="f1b31a4f-f065-4b87-a9a9-eb802130c87d"
  issuer="https://login.microsoftonline.com/6ee623a2-0b05-4ea4-b931-79c555955cb1/v2.0/"
  redirect_uri="http://localhost:4000"
  post_logout_redirect_uri="http://localhost:4000"
>
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
              <LogoutButton>Log Out</LogoutButton>
            </DropdownMenu>
          </Dropdown>
        {:else}
          <Dropdown>
            <DropdownButton>Log In</DropdownButton>
            <DropdownMenu right>
              <LoginButton>Azure</LoginButton>
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
</OidcContext>

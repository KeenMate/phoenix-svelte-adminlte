<script>
  import { onMount, setContext } from "svelte";
  import { get } from "svelte/store";
  import Router from "svelte-spa-router";
  import keymage from "keymage";

  import "./locale/i18n";
  import routes, { Routes } from "./routes";

  import currentUser from "./stores/current-user";
  import sidebarOpenState from "./stores/sidebar-open-state";

  import { TopNavigation, PageHeader, Sidebar, NavItem, Loader } from "svelte-adminlte";

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

<div class="wrapper">
  <TopNavigation displayName={($currentUser && $currentUser.display_name) || "Unknown"} />
  <Sidebar>
    {#each Routes as route}
      {#if !route.hide}
        <NavItem icon={route.icon} href="#{route.route}">{route.name}</NavItem>
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

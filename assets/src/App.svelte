<script>
  import { onMount, setContext } from "svelte";
  import { get } from "svelte/store";
  import Router from "svelte-spa-router";
  import keymage from "keymage";

  import "./locale/i18n";
  import { changeLang, locale, languages } from "./locale/i18n";
  import { _ } from "svelte-i18n";
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
    Radio,
    Label
  } from "svelte-adminlte";

  import MessageLog from "./controls/modals/MessageLog.svelte";
  import { initSocket } from "./providers/socket";
  import { each } from "svelte/internal";

  function applySidebarOpenState() {
    if (!get(sidebarOpenState)) {
      document.body.classList.add(
        "sidebar-collapse",
        "sidebar-mini-expand-feature"
      );
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
  let localeLanguage = "";
  let selectedLanguage;
  $: changeLanguage(selectedLanguage);
  const subscription = locale.subscribe((x) => (localeLanguage = x));
  setContext("loader", {
    setLoading: (val) => (loading = val),
  });

  function changeLanguage(lang) {
    console.log(lang)
    if (lang) {
      changeLang(lang);
    }
  }

  onMount(appMountCallback);

  console.log(locale.subscribe);
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
      <Dropdown>
        <DropdownButton>{$_("home.language")}</DropdownButton>
        <DropdownMenu right>
          {#each languages as l}
          <Radio id={"langRadio-"+l} level="danger" bind:group={selectedLanguage} name="lang" value={l}>
            <Label inputId={"langRadio-"+l}>{l}</Label>
          </Radio>
          {/each}
        </DropdownMenu>
      </Dropdown>
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
            <DropdownItem on:click={() => login(AzureProvider)}
              >Azure</DropdownItem
            >
            <DropdownItem on:click={() => login(ZuubrProvider)}
              >Zuubr</DropdownItem
            >
          </DropdownMenu>
        </Dropdown>
      {/if}
    </svelte:fragment>
  </TopNavigation>

  <Sidebar>
    {#each Routes as route}
      {#if !route.hide}
        <SidebarNavItem icon={route.icon} href="#{route.route}"
          ><p>{route.title}</p></SidebarNavItem
        >
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

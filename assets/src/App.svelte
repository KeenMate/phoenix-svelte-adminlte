<script>
  import { onMount, setContext } from "svelte";
  import { get } from "svelte/store";
  import Router from "svelte-spa-router";
  import keymage from "keymage";
  import "./locale/i18n";
  import { locale } from "./locale/i18n";
  import routes, { Routes } from "./routes";
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
    Sidebar,
    SidebarNavItem,
    TopNavItem,
    Dropdown,
    DropdownItem,
    DropdownButton,
    DropdownMenu,
  } from "svelte-adminlte";
  import MessageLog from "./components/modals/MessageLog.svelte";
  import { initSocket } from "./providers/socket";
  import SidebarNavTree from "./components/SidebarNavTree.svelte";
  import LocaleDropdown from "./components/localEditor/LocaleDropdown.svelte";
  import { _ } from "svelte-i18n";

  import SvelteSelect from "svelte-select";
  onMount(() => {
    initSocket();
    keymage("ctrl-0", () => {
      console.log("opening logs");
      showLog();
    });
  });
  let loading = false;
  let showLog;
  let localeLanguage = "";
  const subscription = locale.subscribe((x) => (localeLanguage = x));
  setContext("loader", {
    setLoading: (val) => (loading = val),
  });
  onMount(appMountCallback);

  let fonts = [
    {
      label: "Source Sans Pro",
      value:
        '"Source Sans Pro", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol"',
    },
    { label: "Report", value: "Report" },
    { label: "Assailand", value: "Assailand" },
    { label: "Iunito", value: "Iunito" },
    { label: "Codec Pro", value: "Codec Pro" },
    { label: "Betinya Sans", value: "Betinya Sans" },
    { label: "Acephimere", value: "Acephimere" },
    { label: "Tepeno Sans", value: "Tepeno Sans" },
    { label: "Homizio Nova", value: "Homizio Nova" },
  ];

  function changeFont(ev) {
    console.log(ev.detail.value);
    document.querySelector("body").style.fontFamily = ev.detail.value;
  }
</script>

<div class="wrapper">
  <TopNavigation>
    <svelte:fragment slot="left">
      <TopNavItem href="#/">Home</TopNavItem>
      <Dropdown>
        <DropdownButton>Pages</DropdownButton>

        <DropdownMenu>
          {#each Routes as route}
            {#if !route.hide}
              <DropdownItem href={"#" + route.route}>{route.title}</DropdownItem
              >
            {/if}
          {/each}
        </DropdownMenu>
      </Dropdown>
    </svelte:fragment>

    <svelte:fragment slot="right">
      <SvelteSelect
        items={fonts}
        on:select={changeFont}
        value={fonts[0]}
        containerClasses="minWidth"
      />
      <LocaleDropdown />
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
              >Azure
            </DropdownItem>
            <DropdownItem on:click={() => login(ZuubrProvider)}
              >Zuubr
            </DropdownItem>
          </DropdownMenu>
        </Dropdown>
      {/if}
    </svelte:fragment>
  </TopNavigation>

  <Sidebar>
    {#each Routes as route}
      {#if !route.hide}
        {#if route.nesting}
          <SidebarNavTree icon={route.icon} href="#{route.route}"
            >{$_("routes."+route.name+".navtitle",{default: route.title})} 
            <svelte:fragment slot="children">
              {#each route.subroutes as sub}
                <SidebarNavItem icon={sub.icon} href="#{sub.route}">
                  <p>{sub.title}</p>
                </SidebarNavItem>
              {/each}
            </svelte:fragment>
          </SidebarNavTree>
        {:else}
          <SidebarNavItem icon={route.icon} href="#{route.route}">
            <p>{$_("routes."+route.name+".navtitle",{default: route.title})} </p>
          </SidebarNavItem>
        {/if}
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

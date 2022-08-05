<script>
	import {onMount, setContext} from "svelte"
	import Router from "svelte-spa-router"
	import keymage from "keymage"
	import {
		TopNavigation,
		Sidebar,
		SidebarNavItem,
		TopNavItem,
		Dropdown,
		DropdownItem,
		DropdownButton,
		DropdownMenu
	} from "@keenmate/svelte-adminlte"
	import {Multiselect} from "svelte-multiselect"
	import {_} from "svelte-i18n"
	import jQuery from "jquery"
	import {AppUrl} from "./constants/urls"
	import Fonts from "./constants/fonts"
	import "./locale/i18n"
	import routes, {Routes} from "./routes"
	import {
		login,
		isAuthenticated,
		userInfo,
		AzureProvider,
		ZuubrProvider,
		appMountCallback,
		logout, loginViaApp
	} from "./stores/authentication"
	import {loadCurrentUser} from "./stores/current-user"
	import {initSocket} from "./providers/socket"
	import MessageLog from "./components/modals/MessageLog.svelte"
	import SidebarNavTree from "./components/SidebarNavTree.svelte"
	import LocaleDropdown from "./components/localEditor/LocaleDropdown.svelte"

	let loading = false
	let showLog
	let condensed = false

	setContext("loader", {
		setLoading: (val) => (loading = val)
	})

	onMount(() => {
		initSocket()
		keymage("ctrl-0", () => {
			console.log("opening logs")
			showLog()
		})
		appMountCallback()
		loadCurrentUser()

		jQuery(function () {
			jQuery("[data-toggle=\"tooltip\"]").tooltip({delay: {show: 800, hide: 0}})
		})

		//will set initial condension
		setCondensed()
	})

	function changeFont(ev) {
		console.log(ev.detail.value)
		document.querySelector("body").style.fontFamily = ev.detail.value
	}

	function setCondensed() {
		condensed = !condensed
		if (condensed) {
			document.body.classList.add("condensed")
		} else {
			document.body.classList.remove("condensed")
		}
		// setTimeout(() => {
		//
		// })
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
			<TopNavItem>
				{#if AppUrl.startsWith("http://l")}
					<span class="text-danger font-weight-bold">LOCALHOST</span>
				{:else}
					{AppUrl.startsWith("https://d") ? "DEV" : "MAIN"}
				{/if}
			</TopNavItem>
		</svelte:fragment>

		<svelte:fragment slot="right">
			<!-- <SvelteSelect
				items={fonts}
				on:select={changeFont}
				value={fonts[0]}
				containerClasses="minWidth"
			/> -->
			<div class="m-1">
				<Multiselect
					small
					options={Fonts}
					on:input={changeFont}
					showLabels={false}
					value={Fonts[0]}
					trackBy="value"
					label="label"
					class="p1"
					allowEmpty={false}
				/>
			</div>

			<div class="m-1">
				<LocaleDropdown />
			</div>
			{#if $isAuthenticated}
				<Dropdown slot="right">
					<DropdownButton>{$userInfo.displayName}</DropdownButton>

					<DropdownMenu right>
						<DropdownItem on:click={logout}>Log Out</DropdownItem>
						<DropdownItem on:click={setCondensed}>
							{condensed ? "Mobile" : "Condensed"} style
						</DropdownItem>
					</DropdownMenu>
				</Dropdown>
			{:else}
				<Dropdown>
					<DropdownButton>Log In</DropdownButton>
					<DropdownMenu right>
						<DropdownItem on:click={loginViaApp}>
							PhoenixSvelteAdminLTE
						</DropdownItem>
						<!--<DropdownItem on:click={() => login(AzureProvider)}>-->
						<!--	Azure-->
						<!--</DropdownItem>-->
						<!--<DropdownItem on:click={() => login(ZuubrProvider)}>-->
						<!--	Zuubr-->
						<!--</DropdownItem>-->
					</DropdownMenu>
				</Dropdown>
			{/if}
		</svelte:fragment>
	</TopNavigation>

	<Sidebar>
		{#each Routes as route}
			{#if !route.hide}
				{#if route.nesting}
					<SidebarNavTree
						icon={route.icon}
						href="#{route.route}"
					>
						{$_("routes." + route.name + ".navtitle", {default: route.title})}
						<svelte:fragment slot="children">
							{#each route.subroutes as sub}
								<SidebarNavItem icon={sub.icon} href="#{sub.route}">
									<p>{sub.title}</p>
								</SidebarNavItem>
							{/each}
						</svelte:fragment>
					</SidebarNavTree>
				{:else}
					<SidebarNavItem
						icon={route.icon}
						href="#{route.route}"
						tooltip={$_("routes." + route.name + ".tooltip", { default: "" })}
					>
						<p>
							{$_("routes." + route.name + ".navtitle", {
								default: route.title,
							})}
						</p>
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

<style>
	.dropdown-item {
		cursor: pointer;
		white-space: nowrap;
	}
</style>

<script>
	import { onMount } from "svelte";
	import {
		changeLang,
		languages,
		getFlagPath,
		locale,
	} from "../../locale/i18n";
	import { Dropdown, DropdownMenu, DropdownButton } from "svelte-adminlte";
	import { Multiselect } from "svelte-multiselect";
	let localeLanguage = "";
	onMount(() => {
		const subscription = locale.subscribe((x) => (localeLanguage = x));
	});
	function changeLanguage(lang) {
		console.log(lang);
		if (!lang) return;
		changeLang(lang.code);
		//location.reload();
	}

	let value;

	$: value = languages.find((x) => x.code == localeLanguage);
</script>

<!-- <div class="language-dropdown">
	<Dropdown>
		<DropdownButton>
			<img
				src={getFlagPath(localeLanguage)}
				class="selected-locale-img"
				alt={localeLanguage}
			/>
		</DropdownButton>

		<DropdownMenu right>
			{#each languages as l (l.code)}
				<div class="lang-item" on:click={() => changeLanguage(l.code)}>
					<img src={getFlagPath(l.code)} alt={l.img} />
					{l.title || l.code}
				</div>
			{/each}
		</DropdownMenu>
	</Dropdown>
</div> -->

<div class="multiselect">
	<Multiselect
		optionHeight={31}
		options={languages}
		on:input={(e) => changeLanguage(e.detail)}
		showLabels={false}
		trackBy="code"
		searchable={false}
		{value}
		customLabel={(o) => o?.code + "-" + o.value}
		allowEmpty={false}
	>
		<svelte:fragment slot="option" let:option>
			<img src={getFlagPath(option.code)} alt={option.code} />
			{option.value || option.code}
		</svelte:fragment>

		<svelte:fragment slot="singleLabel">
			<img
				src={getFlagPath(localeLanguage)}
				class="selected-locale-img"
				alt={localeLanguage}
			/>
		</svelte:fragment>
	</Multiselect>
</div>

<style>
	.selected-locale-img {
		vertical-align: initial;
	}
</style>

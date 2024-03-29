<script>
	import { _ } from "svelte-i18n";
	import {
		PageHeader,
		BreadcrumbItem,
		Card,
		WarningAlert,
	} from "svelte-adminlte";
	import { countries } from "../constants/countries";

	import { Multiselect } from "svelte-multiselect";
	import ComponentExampleTemplate from "../components/component-templates/ComponentExampleTemplate.svelte";
	import github from "svelte-highlight/src/styles/github";
	import SvelteMarkdown from "svelte-markdown";

	import texts from "../texts/multiselectTexts.js";
	let stringOptions = [
		"Select option",
		"options",
		"selected",
		"mulitple",
		"label",
		"searchable",
		"clearOnSelect",
		"hideSelected",
		"maxHeight",
		"allowEmpty",
		"showLabels",
		"onChange",
		"touched",
	];

	const objectOptions = [
		{ name: "Vue.js", language: "JavaScript" },
		{ name: "Rails", language: "Ruby" },
		{ name: "Sinatra", language: "Ruby" },
		{ name: "Laravel", language: "PHP", $isDisabled: true },
		{ name: "Phoenix", language: "Elixir" },
	];

	let value1, value2, value3, value4, value5;

	//#region async

	let searchedCountries = [],
		selectedCountries = [],
		isLoading = false;

	async function getOptions(query) {
		return new Promise((resolve, reject) => {
			setTimeout(() => {
				resolve(
					countries.filter((c) =>
						c.name.toLocaleLowerCase().includes(query.toLocaleLowerCase())
					)
				);
			}, 300);
		});
	}

	//#endregion

	//#region Tagging

	let taggingValue = [];

	let taggingOptions = [
		{ name: "Vue.js", code: "vu" },
		{ name: "Javascript", code: "js" },
		{ name: "Open Source", code: "os" },
	];

	function addTag(e) {
		const tag = {
			name: e.detail,
			code: e.detail.substring(0, 2) + Math.floor(Math.random() * 10000000),
		};
		taggingOptions.push(tag);
		//will force reactivity
		taggingValue = [...taggingValue, tag];
	}

	//#endregion

	//#region custom template
	let customValue;
	let customOptions = [
		{
			title: "Space Pirate",
			desc: "More space battles!",
			img: "https://vue-multiselect.js.org/static/posters/fleet.png",
		},
		{
			title: "Merchant",
			desc: "PROFIT!",
			img: "https://vue-multiselect.js.org/static/posters/trading_post.png",
		},
		{
			title: "Explorer",
			desc: "Discovering new species!",
			img: "https://vue-multiselect.js.org/static/posters/creatures.png",
		},
		{
			title: "Miner",
			desc: "We need to go deeper!",
			img: "https://vue-multiselect.js.org/static/posters/resource_lab.png",
		},
	];

	//#endregion

	//#region groups
	let groupOptions = [
		{
			language: "Javascript",
			libs: [
				{ name: "Vue.js", category: "Front-end" },
				{ name: "Adonis", category: "Backend" },
			],
		},
		{
			language: "Ruby",
			libs: [
				{ name: "Rails", category: "Backend" },
				{ name: "Sinatra", category: "Backend" },
			],
		},
		{
			language: "Other",
			libs: [
				{ name: "Laravel", category: "Backend" },
				{ name: "Phoenix", category: "Backend" },
			],
		},
	];

	let groupValue;
	//#endregion

	//#region actions
	let actions = ["alert", "console.log", "scrollTop"];

	function dispatchAction(e) {
		let actionName = e.detail;
		switch (actionName) {
			case "alert":
				window.alert('You just dispatched "alert" action!');
				break;
			case "console.log":
				console.log('You just dispatched "console.log" action!');
				break;
			case "scrollTop":
				window.scrollTo(0, 0);
				break;
		}
	}
	//#endregion

	//#region custom configuration
	let isDisabled = false,
		isTouched = false,
		customConfigurationValue = [],
		customConfigurationOptions = [
			"Select option",
			"Disable me!",
			"Reset me!",
			"mulitple",
			"label",
			"searchable",
		];
	let isInvalid;
	$: isInvalid =
		isTouched &&
		(customConfigurationValue?.length === 0 ||
			customConfigurationValue == null);

	$: console.log(isInvalid);

	function onChange(value) {
		customConfigurationValue = value;
		if (customConfigurationValue.indexOf("Reset me!") !== -1)
			customConfigurationValue = [];
	}
	function onSelect(option) {
		if (option === "Disable me!") isDisabled = true;
	}
	function onTouch() {
		console.log("touched");
		isTouched = true;
	}
	//#endregion
</script>

<svelte:head>
	{@html github}
</svelte:head>
<PageHeader>
	<svelte:fragment>
		{$_("multiselect.title")}
	</svelte:fragment>

	<svelte:fragment slot="breadcrumbs">
		<BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
		<BreadcrumbItem active>
			{$_("multiselect.title")}
		</BreadcrumbItem>
	</svelte:fragment>
</PageHeader>

<div class="row">
	<div class="col-12">
		<Card>
			<SvelteMarkdown source={texts.aboutText} />
		</Card>

		<ComponentExampleTemplate code={texts.singleSelect} name="Single select">
			<label class="typo__label">Single select</label>
			<Multiselect
				small
				optionHeight={31}
				bind:value={value1}
				options={stringOptions}
				searchable={false}
				closeOnSelect={false}
				showLabels={false}
				placeholder="Pick a value"
			/>
			<pre class="language-json"><code>{value1 ?? ""}</code></pre>
		</ComponentExampleTemplate>

		<ComponentExampleTemplate code={texts.object} name="Single select (object)">
			<label class="typo__label">Single select / dropdown</label>
			<Multiselect
				small
				optionHeight={31}
				bind:value={value2}
				options={objectOptions}
				deselectLabel="Can't remove this value"
				trackBy="name"
				label="name"
				placeholder="Select one"
				searchable={false}
				allowEmpty={false}
			/>
			<pre class="language-json"><code>{value2?.language ?? ""}</code></pre>
		</ComponentExampleTemplate>

		<ComponentExampleTemplate code={texts.search} name="Select with search">
			<label class="typo__label">Select with search</label>
			<Multiselect
				small
				optionHeight={31}
				bind:value={value3}
				options={objectOptions}
				customLabel={({ name, language }) => {
					return `${name} — [${language}]`;
				}}
				placeholder="Select one"
				label="name"
				trackBy="name"
			/>
			<pre class="language-json"><code>{JSON.stringify(value3) ?? ""}</code
				></pre>
		</ComponentExampleTemplate>

		<ComponentExampleTemplate code={texts.multiselect} name="Multiple select">
			<label class="typo__label">Simple select / dropdown</label>
			<Multiselect
				small
				optionHeight={31}
				bind:value={value4}
				options={objectOptions}
				multiple={true}
				closeOnSelect={false}
				clearOnSelect={false}
				preserveSearch={true}
				placeholder="Pick some"
				label="name"
				trackBy="name"
				preselectFirst={true}
				max={10}
			>
				<svelte:fragment slot="selection" let:values let:search let:isOpen>
					{#if values.length && !isOpen}
						{values.length} options selected
					{/if}
				</svelte:fragment>
			</Multiselect>
			<pre class="language-json"><code>{JSON.stringify(value4) ?? ""}</code
				></pre>
		</ComponentExampleTemplate>

		<ComponentExampleTemplate
			code={texts.async}
			name="Asynchronous select"
		>
			<label class="typo__label">Async multiselect</label>
			<Multiselect
				small
				bind:value={selectedCountries}
				label="name"
				trackBy="code"
				placeholder="Type to search"
				options={searchedCountries}
				multiple={true}
				searchable={true}
				loading={isLoading}
				internalSearch={false}
				clearOnSelect={false}
				closeOnSelect={false}
				optionsLimit={300}
				limit={3}
				limitText={(c) => {
					return `and ${c} other countries`;
				}}
				maxHeight={600}
				hideSelected={true}
				on:search-change={(e) => {
					if (e.detail) {
						isLoading = true;
						getOptions(e.detail).then((response) => {
							searchedCountries = response;
							isLoading = false;
						});
					}
				}}
			>
				<svelte:fragment slot="tag" let:option let:remove>
					<span class="custom__tag"
						><span>{option.name}</span><span
							class="custom__remove"
							on:click={() => {
								console.log(option);
								remove(option);
							}}>❌</span
						></span
					>
				</svelte:fragment>

				<svelte:fragment slot="clear">
					{#if selectedCountries.length}
						<div
							class="multiselect__clear"
							on:mousedown|preventDefault|stopPropagation={() =>
								(selectedCountries = [])}
						/>
					{/if}
				</svelte:fragment>

				<span slot="noResult"
					>Oops! No elements found. Consider changing the search query.</span
				>
			</Multiselect>
			<pre class="language-json"><code>{JSON.stringify(value5) ?? ""}</code
				></pre>
		</ComponentExampleTemplate>
		<ComponentExampleTemplate code={texts.tagging} name="Tagging">
			<label class="typo__label">Tagging</label>
			<Multiselect
				small
				bind:value={taggingValue}
				tagPlaceholder="Add this as new tag"
				placeholder="Search or add a tag"
				label="name"
				trackBy="code"
				options={taggingOptions}
				multiple
				taggable
				on:tag={addTag}
			/>
			<pre class="language-json"><code
					>{JSON.stringify(taggingValue) ?? ""}</code
				></pre>
		</ComponentExampleTemplate>
		<ComponentExampleTemplate code={texts.custom} name="Custom option template">
			<label class="typo__label">Custom option template</label>
			<Multiselect
				small
				bind:value={customValue}
				placeholder="Fav No Man’s Sky path"
				label="title"
				trackBy="title"
				options={customOptions}
				optionHeight={104}
				customLabel={({ title, desc }) => `${title} – ${desc}`}
				showLabels={false}
			>
				<svelte:fragment slot="singleLabel" let:option>
					<img class="option__image" src={option.img} alt="No Man’s Sky" /><span
						class="option__desc"
						><span class="option__title">{option.title}</span></span
					>
				</svelte:fragment>
				<svelte:fragment slot="option" let:option>
					<img class="option__image" src={option.img} alt="No Man’s Sky" />
					<div class="option__desc">
						<span class="option__title">{option.title}</span><span
							class="option__small">{option.desc}</span
						>
					</div>
				</svelte:fragment>
			</Multiselect>
			<pre class="language-json"><code>{JSON.stringify(customValue) ?? ""}</code
				></pre>
		</ComponentExampleTemplate>
		<ComponentExampleTemplate code={texts.groups} name="Groups">
			<label class="typo__label">Groups</label>
			<Multiselect
				small
				bind:value={groupValue}
				options={groupOptions}
				multiple
				groupValues="libs"
				groupLabel="language"
				groupSelect
				placeholder="Type to search"
				trackBy="name"
				label="name"
			>
				<span slot="noResult"
					>Oops! No elements found. Consider changing the search query.</span
				>
			</Multiselect>
			<pre class="language-json"><code>{JSON.stringify(groupValue) ?? ""}</code
				></pre>
		</ComponentExampleTemplate>
		<ComponentExampleTemplate code={texts.actions} name="Action dispatcher">
			<label class="typo__label">Open console to see logs.</label>
			<Multiselect
				small
				placeholder="Pick action"
				options={actions}
				searchable={false}
				resetAfter
				on:select={dispatchAction}
			/>
		</ComponentExampleTemplate>

		<ComponentExampleTemplate code={texts.conf} name="Custom configuration">
			<label class="typo__label">Customized multiselect</label>
			<Multiselect
				small
				placeholder="Pick at least one"
				selectLabel="Enter doesn’t work here!"
				value={customConfigurationValue}
				options={customConfigurationOptions}
				multiple
				searchable
				allowEmpty={false}
				hideSelected
				maxHeight={150}
				max={3}
				disabled={isDisabled}
				blockKeys={["Tab", "Enter"]}
				on:input={(e) => onChange(e.detail)}
				on:close={(e) => onTouch(e.detail)}
				on:select={(e) => onSelect(e.detail)}
			/>

			{#if isInvalid}
				<WarningAlert closable={false}
					>Must have at least one value</WarningAlert
				>
			{/if}
		</ComponentExampleTemplate>
	</div>
</div>

<style>
	.multiselect__clear {
		position: absolute;
		right: 41px;
		height: 31px;
		width: 31px;
		display: block;
		cursor: pointer;
		z-index: 2;
	}
	.multiselect__clear:after,
	.multiselect__clear:before {
		content: "";
		display: block;
		position: absolute;
		width: 3px;
		height: 16px;
		background: #aaa;
		top: 8px;
		right: 4px;
	}
	.multiselect__clear:before {
		transform: rotate(45deg);
	}
	.multiselect__clear:after {
		transform: rotate(-45deg);
	}
	.typo__label {
		font-weight: 400;
		font-size: 0.875rem;
		color: #bbb;
		margin: 1.25rem 0 0.625rem;
	}
	.typo__label,
	.typo__text {
		font-family: Lato, sans-serif;
		display: block;
	}

	.custom__tag {
		display: inline-block;
		padding: 3px 8px;
		background: #d2d7ff;
		margin-right: 4px;
		margin-bottom: 4px;
		border-radius: 10px;
		cursor: pointer;
	}
	.custom__tag:nth-child(2n) {
		background: #daffee;
	}
	.custom__tag:hover {
		background: #eaeaea;
	}
	.custom__remove {
		padding: 0;
		font-size: 10px;
		margin-left: 5px;
	}
	.option__image {
		max-height: 80px;
		margin-right: 10px;
	}
	.option__desc,
	.option__image {
		display: inline-block;
		vertical-align: middle;
	}
	.option__desc {
		padding: rem(10px);
	}
	.option__title {
		font-size: rem(24px);
	}
	.option__small {
		margin-top: rem(10px);
		display: block;
	}
</style>

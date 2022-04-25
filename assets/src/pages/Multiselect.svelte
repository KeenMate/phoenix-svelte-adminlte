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

	let singleSelectCode =
		'<label class="typo__label">Single select</label>\r<Multiselect\r\tbind:value={value1}\r\toptions={stringOptions}\r\tsearchable={false}\r\tcloseOnSelect={false}\r\tshowLabels={false}\r\tplaceholder="Pick a value"\r/>\r<pre class="language-json"><code>{value1 ?? ""}</code></pre>';
	let objectCode =
		'<label class="typo__label">Single select / dropdown</label>\r<Multiselect\r\tbind:value={value2}\r\toptions={objectOptions}\r\tdeselectLabel="Can\'t remove this value"\r\ttrackBy="name"\r\tlabel="name"\r\tplaceholder="Select one"\r\tsearchable={false}\r\tallowEmpty={false}\r/>\r<pre class="language-json"><code>{value2?.language ?? ""}</code></pre>';
	let searchCode =
		'<label class="typo__label">Select with search</label>\r<Multiselect\r\tbind:value={value3}\r\toptions={objectOptions}\r\tcustomLabel={({ name, language }) => {\r\t\treturn `${name} — [${language}]`;\r\t}}\r\tplaceholder="Select one"\r\tlabel="name"\r\ttrackBy="name"\r/>\r<pre class="language-json"><code>{JSON.stringify(value3) ?? ""}</code\r\t></pre>';
	let multiselectCode =
		'<label class="typo__label">Simple select / dropdown</label>\r<Multiselect\r\tbind:value={value4}\r\toptions={objectOptions}\r\tmultiple={true}\r\tcloseOnSelect={false}\r\tclearOnSelect={false}\r\tpreserveSearch={true}\r\tplaceholder="Pick some"\r\tlabel="name"\r\ttrackBy="name"\r\tpreselectFirst={true}\r\tmax={10}\r>\r\t<svelte:fragment slot="selection" let:values let:search let:isOpen>\r\t\t{#if values.length && !isOpen}\r\t\t\t{values.length} options selected\r\t\t{/if}\r\t</svelte:fragment>\r</Multiselect>\r<pre class="language-json"><code>{JSON.stringify(value4) ?? ""}</code\r\t></pre>';

	let asyncCode =
		'<label class="typo__label">Async multiselect</label>\r<Multiselect\r\tbind:value={selectedCountries}\r\tlabel="name"\r\ttrackBy="code"\r\tplaceholder="Type to search"\r\toptions={searchedCountries}\r\tmultiple={true}\r\tsearchable={true}\r\tloading={isLoading}\r\tinternalSearch={false}\r\tclearOnSelect={false}\r\tcloseOnSelect={false}\r\toptionsLimit={300}\r\tlimit={3}\r\tlimitText={(c) => {\r\t\treturn `and ${c} other countries`;\r\t}}\r\tmaxHeight={600}\r\thideSelected={true}\r\ton:search-change={(e) => {\r\t\tif (e.detail) {\r\t\t\tisLoading = true;\r\t\t\tgetOptions(e.detail).then((response) => {\r\t\t\t\tsearchedCountries = response;\r\t\t\t\tisLoading = false;\r\t\t\t});\r\t\t}\r\t}}\r>\r\t<svelte:fragment slot="tag" let:option let:remove>\r\t\t<span class="custom__tag"\r\t\t\t><span>{option.name}</span><span\r\t\t\t\tclass="custom__remove"\r\t\t\t\ton:click={() => {\r\t\t\t\t\tconsole.log(option);\r\t\t\t\t\tremove(option);\r\t\t\t\t}}>❌</span\r\t\t\t></span\r\t\t>\r\t</svelte:fragment>\r\r\t<svelte:fragment slot="clear">\r\t\t{#if selectedCountries.length}\r\t\t\t<div\r\t\t\t\tclass="multiselect__clear"\r\t\t\t\ton:mousedown|preventDefault|stopPropagation={() =>\r\t\t\t\t\t(selectedCountries = [])}\r\t\t\t>\r\t\t\t\t❌\r\t\t\t</div>\r\t\t{/if}\r\t</svelte:fragment>\r\r\t<span slot="noResult"\r\t\t>Oops! No elements found. Consider changing the search query.</span\r\t>\r</Multiselect>\r<pre class="language-json"><code>{JSON.stringify(value5) ?? ""}</code\r\t></pre>';
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
		<Card>info text</Card>

		<ComponentExampleTemplate code={singleSelectCode} name="Single select">
			<label class="typo__label">Single select</label>
			<Multiselect
				bind:value={value1}
				options={stringOptions}
				searchable={false}
				closeOnSelect={false}
				showLabels={false}
				placeholder="Pick a value"
			/>
			<pre class="language-json"><code>{value1 ?? ""}</code></pre>
		</ComponentExampleTemplate>

		<ComponentExampleTemplate code={objectCode} name="Single select (object)">
			<label class="typo__label">Single select / dropdown</label>
			<Multiselect
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

		<ComponentExampleTemplate code={searchCode} name="Select with search">
			<label class="typo__label">Select with search</label>
			<Multiselect
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

		<ComponentExampleTemplate code={multiselectCode} name="Multiple select">
			<label class="typo__label">Simple select / dropdown</label>
			<Multiselect
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

		<ComponentExampleTemplate code={multiselectCode} name="Asynchronous select">
			<label class="typo__label">Async multiselect</label>
			<Multiselect
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
						>
							❌
						</div>
					{/if}
				</svelte:fragment>

				<span slot="noResult"
					>Oops! No elements found. Consider changing the search query.</span
				>
			</Multiselect>
			<pre class="language-json"><code>{JSON.stringify(value5) ?? ""}</code
				></pre>
		</ComponentExampleTemplate>
		<Card>
			<svelte:fragment slot="header">Tagging</svelte:fragment>
			<div>
				<label class="typo__label">Tagging</label>
				<Multiselect
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
			</div>
		</Card>
		<Card>
			<svelte:fragment slot="header">Custom option template</svelte:fragment>
			<div>
				<label class="typo__label">Custom option template</label>
				<Multiselect
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
						<img
							class="option__image"
							src={option.img}
							alt="No Man’s Sky"
						/><span class="option__desc"
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
				<pre class="language-json"><code
						>{JSON.stringify(customValue) ?? ""}</code
					></pre>
			</div>
		</Card>
		<Card>
			<svelte:fragment slot="header">Groups</svelte:fragment>
			<div>
				<label class="typo__label">Groups</label>
				<Multiselect
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
				<pre class="language-json"><code
						>{JSON.stringify(groupValue) ?? ""}</code
					></pre>
			</div>
		</Card>
		<Card>
			<svelte:fragment slot="header">Action dispatcher</svelte:fragment>
			<div>
				<label class="typo__label">Open console to see logs.</label>
				<Multiselect
					placeholder="Pick action"
					options={actions}
					searchable={false}
					resetAfter
					on:select={dispatchAction}
				/>
			</div>
		</Card>
		<Card>
			<svelte:fragment slot="header">Custom configuration</svelte:fragment>
			<div>
				<label class="typo__label">Customized multiselect</label>
				<Multiselect
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
			</div>
		</Card>
	</div>
</div>

<style>
	.multiselect__clear {
		position: absolute;
		right: 41px;
		height: 40px;
		width: 40px;
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
		top: 12px;
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
		padding: 3px 12px;
		background: #d2d7ff;
		margin-right: 8px;
		margin-bottom: 8px;
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

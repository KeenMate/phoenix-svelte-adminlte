let aboutText = `
[Svelte-multiselect](https://github.com/KeenMate/svelte-multiselect) is vue-multiselect converted into svelte. Goal is to make as close of a copy as possible.
Below are examples from vue multiselect [docs](https://vue-multiselect.js.org/#sub-getting-started).
Goal was to make exact copies of their examples in svelte, so you can test it and compare differences.

if you set small to true multiselect will have same size as sm bootstrap input
`;

let singleSelect = `
<label class="typo__label">Single select</label>
<Multiselect
	small
	bind:value={value1}
	options={stringOptions}
	searchable={false}
	closeOnSelect={false}
	showLabels={false}
	placeholder="Pick a value"
/>
<pre class="language-json"><code>{value1 ?? ""}</code></pre>
`;

let object = `
<label class="typo__label">Single select / dropdown</label>
<Multiselect
	small
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
`;

let search = `
<label class="typo__label">Select with search</label>
<Multiselect
	small
	bind:value={value3}
	options={objectOptions}
	customLabel={({ name, language }) => {
		return \`\${name} — [\${language}]\`;
	}}
	placeholder="Select one"
	label="name"
	trackBy="name"
/>
<pre class="language-json"><code>{JSON.stringify(value3) ?? ""}</code
	></pre>
`;

let multiselect = `
<label class="typo__label">Simple select / dropdown</label>
<Multiselect
	small
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
`;

let async = `
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
		return \`and \${c} other countries\`;
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
`;

let tagging = `
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
`;

let custom = `
<label class="typo__label">Custom option template</label>
<Multiselect
	small
	bind:value={customValue}
	placeholder="Fav No Man’s Sky path"
	label="title"
	trackBy="title"
	options={customOptions}
	optionHeight={104}
	customLabel={({ title, desc }) => \`\${title} – \${desc}\`}
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
	></pre>`;

let groups = `
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
	></pre>`;

let actions = `
	<label class="typo__label">Open console to see logs.</label>
<Multiselect
	small
	placeholder="Pick action"
	options={actions}
	searchable={false}
	resetAfter
	on:select={dispatchAction}
/>`;

let conf = `
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
{/if}`;
export default {
	singleSelect: singleSelect,
	object: object,
	search: search,
	multiselect: multiselect,
	async: async,
	aboutText: aboutText,
	tagging: tagging,
	custom: custom,
	groups: groups,
	actions: actions,
	conf: conf,
};

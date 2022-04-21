<script>
  import { _ } from "svelte-i18n";
  import { PageHeader, BreadcrumbItem, Card } from "svelte-adminlte";
  import { countries } from "../constants/countries";

  import { Multiselect } from "svelte-multiselect";
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
    <Card>
      <svelte:fragment slot="header">Single select</svelte:fragment>
      <div>
        <label>Single select</label>
        <Multiselect
          bind:value={value1}
          options={stringOptions}
          searchable={false}
          closeOnSelect={false}
          showLabels={false}
          placeholder="Pick a value"
        />
        <pre class="language-json"><code>{value1 ?? ""}</code></pre>
      </div>
    </Card>
    <Card>
      <svelte:fragment slot="header">Single select (object)</svelte:fragment>
      <div>
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
      </div>
    </Card>
    <Card>
      <svelte:fragment slot="header">Select with search</svelte:fragment>
      <div>
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
      </div>
    </Card>
    <Card>
      <svelte:fragment slot="header">Multiple select</svelte:fragment>
      <div>
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
      </div>
    </Card>
    <Card>
      <svelte:fragment slot="header">Asynchronous select</svelte:fragment>
      <div>
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
</style>

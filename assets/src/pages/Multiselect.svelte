<script>
  import { _ } from "svelte-i18n";
  import { PageHeader, BreadcrumbItem, Card } from "svelte-adminlte";

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

  const startObjectOptions = [
    { title: "first", id: 0 },
    { title: "second", id: 1 },
    { title: "third", id: 2 },
    { title: "forth", id: 3 },
    { title: "fifth", id: 4 },
    { title: "six", id: 5 },
    { title: "seventh", id: 6 },
  ];

  let objectOptions = [];
  let value2,value1 ;
  let loading;
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
    <Card>
      <svelte:fragment slot="header">Rychle demo pro Ondru</svelte:fragment>
      <div>
        {JSON.stringify(value1)}

        <div>
          <Multiselect
            bind:value={value1}
            showLabels={true}
            placeholder="Custom placeholder"
            searchable={false}
            closeOnSelect={false}
            options={stringOptions}
            limitText={(x) => `and ${x} other things`}
            deselectLabel="Can't remove this value"
            customLabel={(str) =>str + " + custom function for label" }
          />
        </div>
     pocet znaku v search = pocet polozek, ktere ti to zobrazi
        {JSON.stringify(value2)}

        <Multiselect
          bind:value2={value2}
          showLabels={true}
          closeOnSelect={false}
          searchable={true}
          placeholder="Pick some"
          options={objectOptions}
          trackBy="id"
          label="title"
          multiple={true}
          clearOnSelect={false}
          limit={2}
          preserveSearch={true}
          limitText={(x) => `and ${x} other things`}
          deselectLabel="custom label for deletion"
          customLabel={(obj) => JSON.stringify(obj)}
          internalSearch={false}
          {loading}
          on:search-change={(e, id) => {
            let query = e.detail;
            console.log(query);
            loading = true;
            setTimeout(() => {
              objectOptions = startObjectOptions.slice(0, query?.length);
              loading = false;
            }, 1000);
          }}
        />
      </div>
    </Card>
  </div>
</div>

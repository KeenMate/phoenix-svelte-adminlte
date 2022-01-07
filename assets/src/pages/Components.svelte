<script>
  import { _ } from "svelte-i18n";
  import { replace } from "svelte-spa-router";
  import { PageHeader, BreadcrumbItem, LteButton,Card } from "svelte-adminlte";
  import github from "svelte-highlight/src/styles/github";

  import { components, categories } from "../user-controls/component-examples/components";
  import ComponentList from "../components/component-templates/ComponentList.svelte";
  import SvelteMarkdown from "svelte-markdown";


  let componentInfo = null;
  let category = null;

  export let params = {};

  $: paramsChange(params);
  $: console.log(params);
  //$: console.log(componentInfo);
  //sets component info when parametrs change

  function paramsChange(p) {
    if (p) {
      if (p.code) {
        let info = components.find((x) => x.code == p.code);
        if (info) {
          componentInfo = info;
        } else {
          componentInfo = info;
        }
      } else {
        componentInfo = null;
      }
      if (categories.find((x) => x === p.category)) {
        category = p.category;
      } else {
        category = null;
      }
    }
  }
</script>

<svelte:head>
  {@html github}
</svelte:head>

<PageHeader>
  <svelte:fragment>
    {componentInfo ? componentInfo.name : $_("components.title")}
    <small
      ><SvelteMarkdown
        isInline
        source={componentInfo
          ? componentInfo.breadcrumb /* || $_("components.title")*/
          : "Funny Joke"}
      />
    </small>
  </svelte:fragment>

  <svelte:fragment slot="breadcrumbs">
    <BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>

    {#if componentInfo}
      <BreadcrumbItem>
        <a href="#/components" on:click={() => replace("/components")}
          >{$_("components.title")}</a
        ></BreadcrumbItem
      >
      <BreadcrumbItem active>
        {componentInfo.name}
      </BreadcrumbItem>
    {:else}
      <BreadcrumbItem active>
        {$_("components.title")}
      </BreadcrumbItem>
    {/if}
  </svelte:fragment>
</PageHeader>
<div class="row mh-100">
  <div class="col-12 ">
    {#if componentInfo}
      <svelte:component this={componentInfo.component} />
    {:else}
      <Card color="red" outline>
        <SvelteMarkdown source={$_("components.text")} ></SvelteMarkdown>
      </Card>
      <ComponentList {category} />
    {/if}
  </div>
</div>

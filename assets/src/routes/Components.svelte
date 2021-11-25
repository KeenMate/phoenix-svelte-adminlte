<script>
  import { _ } from "svelte-i18n";
  import { replace } from "svelte-spa-router";
  import { PageHeader, BreadcrumbItem, LteButton } from "svelte-adminlte";
  import github from "svelte-highlight/src/styles/github";

  import { components } from "../component-examples/components";
  import ComponentList from "../controls/Components/ComponentList.svelte";
  let componentInfo = null;

  export let params = {};

  $: setComponentInfo(params);
  $: console.log(params);
  $: console.log(componentInfo);
  //sets component info when parametrs change
  function setComponentInfo(p) {
    if (p && p.code) {
      let info = components.find((x) => x.code == p.code);
      if (info) {
        componentInfo = info;
      } else {
        componentInfo = info;
      }
    } else {
      componentInfo = null;
    }
  }
</script>

<svelte:head>
  {@html github}
</svelte:head>

<PageHeader>
  <svelte:fragment>
    {componentInfo ? componentInfo.name : $_("components.title")}
    <small>{componentInfo ? $_("components.title") : "Funny Joke"}</small>
  </svelte:fragment>

  <svelte:fragment slot="breadcrumbs">
    <BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
    <BreadcrumbItem active>
      {#if componentInfo}
        <a href="#/components" on:click={() => replace("/components")}
          >{$_("components.title")}</a
        >
      {:else}
        {$_("components.title")}
      {/if}
    </BreadcrumbItem>
  </svelte:fragment>
</PageHeader>
<div class="row mh-100 m-1">
  <div class="col-12 ">
    {#if componentInfo}
      <svelte:component this={componentInfo.component} />
    {:else}
      <ComponentList />
    {/if}
  </div>
</div>

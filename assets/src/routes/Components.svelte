<script>
  import { _ } from "svelte-i18n";
  import { PageHeader, BreadcrumbItem,LteButton } from "svelte-adminlte";
  import InputExample from "../component-examples/InputExample.svelte"
  import CardExample from "../component-examples/CardExample.svelte";
  import github from "svelte-highlight/src/styles/github";
  
  import {components} from "../component-examples/components"
  let title="card"
  let componentInfo = null;

  export let params;

  $:setComponentInfo(params)
  $: console.log(params)
  //sets component info when parametrs change
  function setComponentInfo(p){
    if(p && p.code){
     let  info =  components.find((x) => x.code == p.code);
      if(info){
        componentInfo = info
      }
    }
  }

</script>

<svelte:head>
  {@html github}
</svelte:head>

<PageHeader>
    <svelte:fragment>
      {title || $_("components.title")} <small>{title ? $_("components.title") : "Funny Joke" }</small>
    </svelte:fragment>
  
    <svelte:fragment slot="breadcrumbs">
      <BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
      <BreadcrumbItem active>
        {#if title}
        <a href="#/components" on:click="{() => title=null}">{$_("components.title")}</a>
        {:else}
          {$_("components.title")}
        {/if}
        </BreadcrumbItem>
    </svelte:fragment>
  </PageHeader>
<!--TEMPORARY -->
  <div class="row mh-100">
    {#if title === null}
      <LteButton on:click="{() => title="card"}">card</LteButton>
      <LteButton on:click="{() => title="example"}">example</LteButton>
    {:else if  title === "card"}
       <CardExample/>
       {:else if  title === "example"}
          <InputExample />
       {:else}
       asd
    {/if}
  </div>
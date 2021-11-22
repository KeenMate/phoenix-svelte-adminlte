<script>
  import { _ } from "svelte-i18n";
  import { PageHeader, BreadcrumbItem,LteButton } from "svelte-adminlte";
  import ComponentPageExample from "../component-examples/ComponentPageExample.svelte"
import CardExample from "../component-examples/CardExample.svelte";
  
  let title="card"
</script>



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
          <ComponentPageExample />
       {:else}
       asd
    {/if}
  </div>
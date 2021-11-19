<script>
  import {Card} from "svelte-adminlte";
  import { _ } from "svelte-i18n";

  // name value comment
  export let properties = [];
  export let name;
  export let text;
</script>

<div class="row col-12 ml-1">
  <div class="col-8 scroll">

    <slot name="examples" />
  </div>
  <div class="col-4">
    <h1>{name}</h1>
    {#if text}
      <Card>
        <svelte:fragment slot="header">
          {$_("component-page-template.text-title")}
        </svelte:fragment>
        {@html text}
      </Card>
    {/if}
    <Card>
      <svelte:fragment slot="header">
        {$_("component-page-template.props-title")}
      </svelte:fragment>
      {#each properties as prop}
        <b>{prop.name}</b>
        {prop.type}
        <br /><i>{prop.comment}</i>
      {/each}
    </Card>
  </div>
</div>

<style lang="sass">
  .scroll
    overflow: scroll
    height: 80vh
</style>

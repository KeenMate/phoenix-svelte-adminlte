<script>
  import {Card} from "svelte-adminlte";
  import { _ } from "svelte-i18n";

  // name value comment
  export let properties = [];
  //export let name;
  export let text;
</script>

<div class="row col-12 ml-1 ">
  <div class="col-8 scroll">
    <div class="row margin">
    <slot name="examples" />
  </div>
  </div>
  <div class="col-4">
    {#if text}
      <Card color="danger" outline >
        <svelte:fragment slot="header">
          {$_("component-page-template.text-title")}
        </svelte:fragment>
        {@html text}
      </Card>
    {/if}
    <Card color="danger" outline>
      <svelte:fragment slot="header">
        {$_("component-page-template.props-title")}
      </svelte:fragment>
      {#each properties as prop}
      <p>
        <b>{prop.name}</b>
        [{prop.type}]
        <br /><i>{prop.comment}</i>
      </p>
      {/each}
   
    </Card>
  </div>
</div>

<style lang="sass">
  .scroll
    overflow-x: hidden
    overflow-y: visible
    //height: 85vh
  .margin
    margin-left: 1px
  // ::-webkit-scrollbar 
  //   width: 5px
  // ::-webkit-scrollbar-track 
  //   background: #f1f1f1
  // ::-webkit-scrollbar-thumb 
  //   background: #888
  // ::-webkit-scrollbar-thumb:hover
  //   background: #555 
</style>

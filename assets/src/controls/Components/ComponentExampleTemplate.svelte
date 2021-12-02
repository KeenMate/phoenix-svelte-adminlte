<script>
   import { HighlightSvelte } from "svelte-highlight";

  import { Card ,LteButton} from "svelte-adminlte";
  import notification from "../../providers/notificationProvider";

  import { _ } from "svelte-i18n";

  export let name = "";
  export let code = "";

  function copyToClipboard(){
    navigator.clipboard.writeText(code);
    notification.success($_("notifications.component-example-template.copied.message"))
  }
</script>

<Card class="card-width " color="info" outline>
  <svelte:fragment slot="header">{name}</svelte:fragment>
  <svelte:fragment slot="tools"><LteButton color="success" on:click={copyToClipboard} small ><i class="fas fa-copy"></i></LteButton></svelte:fragment>
  <div class="row">
    <div class="col-6">
      <slot />
    </div>
    <div class="col-6 line-left">
      <div class=" highlighter">
          <HighlightSvelte {code}  /></div>
    </div>
  </div>
</Card>

<style lang="sass">
.line-left
  border-left: darkgrey solid 2px
:global
  .card-width
    width: 100%
    margin: 10 20px
    .card-body
      padding: 0.75em
    .row
      min-height: 150px
  .highlighter
    background-color: #f5f5f5
    height: 100%
    box-shadow: 0 0 1px rgb(0 0 0 / 13%), 0 1px 3px rgb(0 0 0 / 20%)
    pre
      margin:0 !important
      padding: 0 0 0 4px !important
      background-color: #f5f5f5
    code
      margin: 0 !important
      padding: 0 !important
      font-size: 0.8em
      white-space: break-spaces
      background-color: #f5f5f5
    

</style>

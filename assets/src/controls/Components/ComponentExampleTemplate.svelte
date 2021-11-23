<script>
   import { HighlightSvelte } from "svelte-highlight";

  import { Card } from "svelte-adminlte";
import { languages } from "../../locale/i18n";
  export let name = "";
  export let code = "";
</script>

<Card class="card-width ">
  <svelte:fragment slot="header">{name}</svelte:fragment>
  <div class="row">
    <div class="col-6">
      <slot />
    </div>
    <div class="col-6 line-left">
      <HighlightSvelte {code}  />
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
  code
    font-size: 0.7em
    white-space: break-spaces
  

</style>

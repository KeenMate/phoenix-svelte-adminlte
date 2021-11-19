<script>
  import { Card } from "svelte-adminlte";
  export let name = "";
  export let code = "";
  console.log(code);
</script>

<Card>
  <svelte:fragment slot="header"><h4>{name}</h4></svelte:fragment>
  <div class="row">
    <div class="col-6">
      <slot name="example" />
    </div>
    <div class="col-6 line-left">
      <code> {code} </code>
    </div>
  </div>
</Card>

<style lang="sass">
    .line-left
        border-left: darkgrey solid 2px
</style>
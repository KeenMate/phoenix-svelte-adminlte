<script>
  import { Card } from "svelte-adminlte";
  export let name = "";
  export let code = "";
  console.log(code);
</script>

<Card class="card-width ">
  <svelte:fragment slot="header">{name}</svelte:fragment>
  <div class="row">
    <div class="col-6">
      <slot />
    </div>
    <div class="col-6 line-left">
      <code> {code} </code>
    </div>
  </div>
</Card>

<style lang="sass">
  .line-left
    border-left: darkgrey solid 2px
  code
    white-space: pre-line
    font-size: 0.7em
  

:global
    .card-width
        width: 100%
        margin: 10 20px

</style>

<script>
  import { createEventDispatcher, getContext } from "svelte";
  import { debounce } from "lodash";
  import { TypingDebounceDelay } from "../../constants/ui";
  import {
    Card,
    TableCondensed,
    LteButton,
    TextInput,
    Form,
    FormGroup,
    InputGroup,
    InputGroupAppend,
    Pagination,
  } from "svelte-adminlte";

  import { components } from "../../component-examples/components";
import { replace } from "svelte-spa-router";
import {fillParams} from "../../routes"
import { _ } from "svelte-i18n";

  const dispatch = createEventDispatcher();

  export let displayedComponents = [];

  let searchInput = null;
  let searchDebounce = debounce(() => getComponents(), TypingDebounceDelay);

  $: searchDebounce(searchInput);
  $: console.log(displayedComponents)
  getComponents();

  function getComponents() {
      if(searchInput == null || searchInput == ""){
        displayedComponents = components;
      }else{
        console.log(`searching components ${searchInput}`)
        displayedComponents = displayedComponents.filter((x)=>  x.name.toLowerCase().includes(searchInput.toLowerCase()) );
      }
  }
</script>

<Card outline color="primary">
  <svelte:fragment slot="header">List</svelte:fragment>

  <div class="row">
    <div class="col-12">
      <Form horizontal>
        <FormGroup>
          <InputGroup>
            <TextInput
              bind:value={searchInput}
              placeholder="Search for user..."
            />
            <InputGroupAppend>
              <LteButton on:click={() => (searchInput = null)} small><i class="fas fa-times" /></LteButton>
            </InputGroupAppend>
          </InputGroup>
        </FormGroup>
      </Form>
    </div>
  </div>

  <div class="row">
    <div class="col-12">
      <TableCondensed class="components-list">
        <tr slot="headers">
          <th>name</th>
            <th>description</th>
        </tr>
        
        {#each displayedComponents as component}
          <tr>
            <td class="title">
              <a
                href="#"
                on:click|preventDefault={() => replace(fillParams("/components/show/:code",{code:component.code}))}
              >
                {component.name}
              </a>
            </td>
              <td>{component.description}</td>
          </tr>
        {/each}
        {#if displayedComponents.length == 0}
          <tr>
              <td class="text-danger">{$_("component-list.not-found.title")}</td>
              <td class="text-muted">{$_("component-list.not-found.text")}</td>
          </tr>
        {/if}
      </TableCondensed>
    </div>
  </div>
</Card>

<style lang="scss">
  .table-status {
    padding-top: 0.85em;
  }

  :global {
    .components-list {
      display: grid;
      grid-template-columns: auto repeat(3, 1fr);

      &:not(.expanded) {
        grid-template-columns: auto 1fr;
      }

      thead,
      tbody,
      * > tr {
        display: contents;
      }
    }
  }
</style>

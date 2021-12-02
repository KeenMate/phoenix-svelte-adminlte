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
    Tabs,
    TabItem,
  } from "svelte-adminlte";

  import { components, categories } from "../../component-examples/components";

  import { push } from "svelte-spa-router";
  import { fillParams } from "../../routes";
  import { _ } from "svelte-i18n";
  import { claim_component } from "svelte/internal";

  const dispatch = createEventDispatcher();

  export let displayedComponents;
  export let category = null;

  let searchInput = null;
  let searchDebounce = debounce(
    () => getComponents(category),
    TypingDebounceDelay
  );

  $: searchDebounce(searchInput);
  $: {category, getComponents()}

  //$: console.log(displayedComponents)
  //$: console.log(category)
  


  function getComponents() {
    console.log("getting components")
    if (searchInput == null || searchInput == "") {
      displayedComponents = components.filter((x) =>
        category === null ? true : x.category == category
      );
    } else {
      console.log(`searching components text:${searchInput}`);
      displayedComponents = components.filter((x) =>
        x.name.toLowerCase().includes(searchInput.toLowerCase())
      );
    }
  }

  function changeCategory(cat) {
    if (cat !== category) {
      if(cat){
      push(
        fillParams("/components/:category", {
          category: cat,
        })
      );
      }else{
        push("/components/")
      }
    }
  }
</script>

<Card outline color="primary">
  <svelte:fragment slot="header"
    >{$_("component-list.card-title")}</svelte:fragment
  >

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
              <LteButton on:click={() => (searchInput = null)} small
                ><i class="fas fa-times" /></LteButton
              >
            </InputGroupAppend>
          </InputGroup>
        </FormGroup>
      </Form>
    </div>
  </div>
  <div class="row">
    <div class="col-12">
      <Tabs>
        <li class="pt-2 px-3">
          <h3 class="card-title">{$_("component-list.categories")}</h3>
        </li>
        <TabItem
          active={category === null}
          on:click={() => changeCategory(null)}
          >{$_("component-list.all")}</TabItem
        >
        {#each categories as c}
          <TabItem active={category === c} on:click={() => changeCategory(c)}
            >{c}</TabItem
          >
        {/each}
      </Tabs>
    </div>
  </div>
  <div class="row">
    <div class="col-12">
      <TableCondensed class="components-list">
        <tr slot="headers">
          <th>{$_("component-list.name")}</th>
          <th>{$_("component-list.description")}</th>
        </tr>

        {#each displayedComponents as component}
          <tr>
            <td class="title">
              <a
                href="#"
                on:click|preventDefault={() =>
                  push(
                    fillParams("/components/show/:code", {
                      code: component.code,
                    })
                  )}
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
      grid-template-columns: minmax(10em, max-content) auto;

      thead,
      tbody,
      * > tr {
        display: contents;
      }
      tr:first-child {
        border-top: none;
      }
    }
  }
</style>

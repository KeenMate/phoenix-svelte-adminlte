<script>
      import { _} from "svelte-i18n";
      import {languages,GetFlagPath} from "../../locale/i18n";
    import { createEventDispatcher } from "svelte";
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
    } from "svelte-adminlte";
  
  
    const dispatch = createEventDispatcher();
  
    export let expanded = false;
    
    let displayedLocales = languages
    console.log(displayedLocales)
    // let searchInput = null;
    // let searchDebounce = debounce(() => searchLocales(), TypingDebounceDelay);
  
    // $: searchDebounce(searchInput);

  
  </script>
  
  <Card  outline color="primary" noPadding>
    <svelte:fragment slot="header">{$_("locales-list.card-title")}</svelte:fragment>
  
    <!--<div slot="tools">
      <LteButton color="info" small on:click={() => dispatch("refresh")}>
        <i class="fas fa-sync" />
      </LteButton>
      <LteButton color="success" small on:click={() => dispatch("create")}>
        <i class="fas fa-plus" />
      </LteButton>
    </div> -->
  
    <!-- <div class="row">
      <div class="col-12">
        <Form horizontal>
          <FormGroup>
            <InputGroup>
              <TextInput bind:value={searchInput} placeholder="Search for user..." />
              <InputGroupAppend>
                <LteButton small><i class="fas fa-times" /></LteButton>
              </InputGroupAppend>
            </InputGroup>
          </FormGroup>
        </Form>
      </div>
    </div> -->
  
    <div class="row">
      <div class="col-12">
        <TableCondensed class="locales-list {expanded ? 'expanded' : ''}">
          <tr slot="headers">
            <!-- <th class="actions">Actions</th> -->
            <th>{$_("locales-list.language")}</th>
            {#if expanded}
              <th>{$_("locales-list.flag")}</th>
              <th>{$_("locales-list.code")}</th>
            {/if}
          </tr>
          {#each displayedLocales as locale}
            <tr>
              <!-- <td class="actions">
                <LteButton color="danger" xsmall on:click={() => onDelete(user)}>
                  <i class="fas fa-trash fa-fw" />
                </LteButton>
              </td> -->
              <td class="title">
                <a href="#" on:click|preventDefault={() => dispatch("edit", locale.code)}>
                  {locale.title}
                </a>
              </td>
              {#if expanded}
                <td> <img src={GetFlagPath(locale.code)} alt={locale.img + " flag"} /> ({locale.img})</td>
                <td>{locale.code}</td>
              {/if}
            </tr>
          {/each}
        </TableCondensed>
      </div>
    </div>
  </Card>
  
  <style lang="scss">
    th {
        border-top: none;
    }
    :global {
      .locales-list {
        display: grid;
        grid-template-columns: auto repeat(2, 1fr);
  
        &:not(.expanded) {
          grid-template-columns:  1fr;
        }
  
        thead,
        tbody,
        * > tr {
          display: contents;
        }
      }
    }
  </style>
  
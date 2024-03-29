<script>
  import { createEventDispatcher, getContext } from "svelte";
  import lazyLoader from "../../helpers/lazy-loader";
  import  debounce  from "lodash/debounce";
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

  import { getUsers } from "../../providers/socket/usersChannel";

  const { setLoading } = getContext("loader");

  const dispatch = createEventDispatcher();

  export let expanded;
  export let users = [];

  let page = 1;
  let loading = false;
  let searchInput = null;
  let searchDebounce = debounce(() => fetchUsers(), TypingDebounceDelay);

  $: searchDebounce(searchInput);

  fetchUsers();

  async function fetchUsers() {
    users = await lazyLoader(
      getUsers(searchInput),
      () => {
        console.log("showing loader");
        loading = true;
      },
      () => {
        console.log("hiding loader");
        loading = false;
      }
    );
  }

  function onDelete(user) {
    
  }
</script>

<Card {loading} outline color="primary">
  <svelte:fragment slot="header">List</svelte:fragment>

  <!--<div slot="tools">
    <LteButton color="info" small on:click={() => dispatch("refresh")}>
      <i class="fas fa-sync" />
    </LteButton>
    <LteButton color="success" small on:click={() => dispatch("create")}>
      <i class="fas fa-plus" />
    </LteButton>
  </div> -->

  <div class="row">
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
  </div>

  <div class="row">
    <div class="col-12">
      <TableCondensed class="user-list {expanded ? 'expanded' : ''}">
        <tr slot="headers">
          <th class="actions">Actions</th>
          <th>Username</th>
          {#if expanded}
            <th>First name</th>
            <th>Last name</th>
          {/if}
        </tr>
        {#each users as user}
          <tr>
            <td class="actions">
              <LteButton color="danger" xsmall on:click={() => onDelete(user)}>
                <i class="fas fa-trash fa-fw" />
              </LteButton>
            </td>
            <td class="title">
              <a href="#" on:click|preventDefault={() => dispatch("edit", user.user_id)}>
                {user.username}
              </a>
            </td>
            {#if expanded}
              <td>{user.first_name}</td>
              <td>{user.last_name}</td>
            {/if}
          </tr>
        {/each}
      </TableCondensed>
    </div>
  </div>

  <div class="row">
    <div class="col-xl-5 col-lg-12">
      <div class="table-status">Showing 1 to 10 of 57 entries</div>
    </div>
    <div class="col-xl-7 col-lg-12">
      <Pagination
        class="justify-content-end"
        {page}
        pages={5}
        visiblePagesCount={5}
        on:updatePage={({ detail: d }) => (page = d)}
      />
    </div>
  </div>
</Card>

<style lang="scss">
  .table-status {
    padding-top: 0.85em;
  }

  :global {
    .user-list {
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

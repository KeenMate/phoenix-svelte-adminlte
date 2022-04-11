<script>
  import {
    PageHeader,
    BreadcrumbItem,
    Card,
    Checkbox,
    LteButton,
    NumberInput,
    Label,
  } from "svelte-adminlte";
  import { _ } from "svelte-i18n";
  import { TreeView } from "svelte-treeview";
  import MenuOption from "svelte-treeview/src/MenuOption.svelte";
  import MenuDivider from "svelte-treeview/src/MenuDivider.svelte";
  import { onMount } from "svelte";
  import treeProvider from "../providers/treeProvider";
  import formatHighlight from 'json-format-highlight'
  let tree = [];
  let recursive = false,
    checkboxes = false,
    leafNodeCheckboxesOnly = false,
    disableOrHide = false,
    thisTree,
    dragAndDrop = true,
    timeToNest = 10000,
    pixelNestTreshold = 150,
    showContexMenu = true,
    enableVerticalLines = false,
    recalculateNodePath = false,
    expandedLevel = 0,
    showNodes = false,
    events = [],
    showConsole = false;

  function handleClick(node) {
    console.log("deleting: "+node.node_path)
    tree = tree.filter((n) => n.node_path != node.node_path);
  }

  function handleEvent(e, t) {
    if (!t) return;
    events.push({ detail: e.detail, type: t });
    events = events;
  }

  function loadInitialTree() {
    treeProvider
      .getTree()
      .then((data) => {
        console.log(data);
        if (data.length) tree = data;
      })
      .catch((er) => console.log(er));
  }

  function loadTree() {
    if (localStorage.tree?.length) {
      tree = JSON.parse(localStorage.tree);
    } else {
      loadInitialTree();
    }
  }
  $: saveTree(tree);
  function saveTree(data) {
    if (tree.length) {
      localStorage.tree = JSON.stringify(data);
    }
  }

  function callback(node, oldParent, targetNode, inspost) {
    console.log(":)")
    console.log(inspost)
    console.log(targetNode)
    if(targetNode?.node_path?.startsWith("4")){
      let teamNodeParth = targetNode?.node_path.slice(0, 3);

      let count = tree.filter((n)=>n.node_path.startsWith(teamNodeParth))?.length
      console.log(count)
      if(!(count <= 5)){
        alert("You can have max 5 heroes in one team")
        return false
      }
    }
    return true
  }

  onMount(() => {
    loadTree();
  });
</script>

<PageHeader>
  <svelte:fragment>
    {$_("tree.title")}
  </svelte:fragment>

  <svelte:fragment slot="breadcrumbs">
    <BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
    <BreadcrumbItem active>
      {$_("tree.title")}
    </BreadcrumbItem>
  </svelte:fragment>
</PageHeader>

<div class="row">
  <div class:col-lg-8={!showConsole} class:col-lg-4={showConsole} class="col-md-12">
    <Card loading={!tree?.length}>
      <svelte:fragment slot="header">
        {$_("tree.treeCardTitle")}
      </svelte:fragment>

      <TreeView
        bind:this={thisTree}
        bind:tree
        treeId="tree"
        on:selection={(e) => handleEvent(e, "selection")}
        on:selected={(e) => handleEvent(e, "selected")}
        on:unselected={(e) => handleEvent(e, "unselected")}
        on:expansion={(e) => handleEvent(e, "expansion")}
        on:expanded={(e) => handleEvent(e, "expanded")}
        on:closed={(e) => handleEvent(e, "closed")}
        on:moved={(e) => handleEvent(e, "moved")}
        let:node
        {recursive}
        {checkboxes}
        {leafNodeCheckboxesOnly}
        {disableOrHide}
        {dragAndDrop}
        {timeToNest}
        {pixelNestTreshold}
        {showContexMenu}
        {enableVerticalLines}
        {recalculateNodePath}
        {expandedLevel}
        nodePathProperty="node_path"
        hasChildrenProperty="has_children"
        isDraggableProperty="is_draggable"
        nestDisabledProperty="nest_disabled"
        insertDisabledProperty="insert_disabled"
        beforeMovedCallback={callback}
        >{#if showNodes}
          {JSON.stringify(node)}
        {:else}
          {node.title}
        {/if}
        <svelte:fragment slot="context-menu" let:node>
          <MenuOption text={node.nodePath} isDisabled />
          <MenuDivider />
          <MenuOption
            text="alert object"
            on:click={alert(JSON.stringify(node))} />
          <MenuOption text="delete node" on:click={handleClick(node)} />
        </svelte:fragment>
      </TreeView>
    </Card>
  </div>

  <div class="col-lg-4 col-md-12">
    <Card>
      <svelte:fragment slot="header">
        {$_("tree.options")}
      </svelte:fragment>
      <LteButton on:click={loadInitialTree}
        >reset tree</LteButton>
      <Checkbox bind:checked={showConsole} id="showConsole"
        ><Label inputId="showConsole">Show console</Label>
      </Checkbox>
      <Checkbox bind:checked={showNodes} id="showNodes"
        ><Label inputId="showNodes">showNodes</Label>
      </Checkbox>

      
      <LteButton on:click={thisTree.changeAllExpansion(false)}
        >colapse All</LteButton>
      <Checkbox bind:checked={checkboxes} id="checkboxes"
        ><Label inputId="checkboxes">checkboxes</Label>
      </Checkbox>
      {#if checkboxes}
        <div style="margin-left: 2em;">
          <Checkbox bind:checked={recursive} id="recursive"
            ><Label inputId="recursive">recursive</Label>
          </Checkbox>
          {#if recursive}
            <div style="margin-left: 2em;">
              <Checkbox
                bind:checked={leafNodeCheckboxesOnly}
                id="leafNodeCheckboxesOnly"
                ><Label inputId="leafNodeCheckboxesOnly"
                  >leafNodeCheckboxesOnly</Label>
              </Checkbox>
              <Checkbox bind:checked={disableOrHide} id="disableOrHide"
                ><Label inputId="disableOrHide">disableOrHide</Label></Checkbox>
            </div>
          {/if}
        </div>
      {/if}

      <Checkbox bind:checked={dragAndDrop} id="dragAndDrop"
        ><Label inputId="dragAndDrop">dragAndDrop</Label>
      </Checkbox>
      {#if dragAndDrop}
        <div style="margin-left: 2em;">
          <NumberInput bind:value={timeToNest} />

          <NumberInput bind:value={pixelNestTreshold} />

          <Checkbox bind:checked={recalculateNodePath} id="recalculateNodePath"
            ><Label inputId="recalculateNodePath">recalculateNodePath</Label
            ></Checkbox>
        </div>
      {/if}
      <Checkbox bind:checked={showContexMenu} id="showContexMenu"
        ><Label inputId="showContexMenu">showContexMenu</Label>
      </Checkbox>
      <Checkbox bind:checked={enableVerticalLines} id="enableVerticalLines"
        ><Label inputId="enableVerticalLines">enableVerticalLines</Label>
      </Checkbox>
      <NumberInput bind:value={expandedLevel} />
    </Card>
  </div>

  {#if showConsole}
    <div class="col-lg-4 col-md-12">
      <Card>
        <svelte:fragment slot="header">
          {$_("tree.events")}
        </svelte:fragment>
        {#each events as ev}
          <ul class="ul">
            <li>
              <b>{ev.type}</b> <br/> <code>{@html formatHighlight(ev.detail)}</code>
            </li>
          </ul>
        {/each}
      </Card>
    </div>
  {/if}
</div>

<style>
  .ul {
    list-style: none;
    margin: 0;
    padding: 0.25em;
  }
</style>

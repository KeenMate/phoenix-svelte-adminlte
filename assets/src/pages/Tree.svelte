<script>
  import {
    PageHeader,
    BreadcrumbItem,
    Card,
    Checkbox,
    LteButton,
    NumberInput
  } from "svelte-adminlte";
  import { _ } from "svelte-i18n";
  import { TreeView } from "svelte-treeview";
  import MenuOption from "svelte-treeview/src/MenuOption.svelte";
  import  MenuDivider from "svelte-treeview/src/MenuDivider.svelte";
  import { onMount } from "svelte";
  import Label from "svelte-adminlte/src/form/structure/Label.svelte";

  let tree = [
    { nodePath: "1" },
    { nodePath: "2" },
    { nodePath: "3", hasChildren: true },
    { nodePath: "3.1" },
    { nodePath: "3.2", hasChildren: true },
    { nodePath: "3.2.1" },
    { nodePath: "3.2.2" },
    { nodePath: "3.2.3" },
    { nodePath: "3.2.4" },
    { nodePath: "3.3" },
  ];

  let recursive = false,
    checkboxes = false,
    leafNodeCheckboxesOnly = false,
    disableOrHide = false,
    thisTree,
    dragAndDrop = false,
    timeToNest = 1000,
    pixelNestTreshold = 150,
    showContexMenu = false,
    enableVerticalLines = false,
    recalculateNodePath = false,
    expandedLevel = 0;

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
  <dir class="col-8">
    <Card>
      <svelte:fragment slot="header">
        {$_("tree.treeCardTitle")}
      </svelte:fragment>

      <TreeView
        bind:this={thisTree}
        bind:tree
        treeId="tree"
        let:node
        {recursive}
        {checkboxes}
        {leafNodeCheckboxesOnly}
        {disableOrHide}
        {dragAndDrop}
        {timeToNest }
        {pixelNestTreshold}
        {showContexMenu}
        {enableVerticalLines}
        {recalculateNodePath}
        {expandedLevel}
      >
        {JSON.stringify(node)}
        <svelte:fragment slot="context-menu" let:node>
          <MenuOption text={node.nodePath} isDisabled />
          <MenuDivider />
          <MenuOption text="alert object" on:click={alert(JSON.stringify(node))} />
          <MenuOption text="delete node" on:click={handleClick(node)} />
        </svelte:fragment>
      </TreeView>
    </Card>
  </dir>
  <dir class="col-4">
    <Card>
      <svelte:fragment slot="header">
        {$_("tree.options")}
      </svelte:fragment>

      <LteButton on:click={thisTree.changeAllExpansion(true)}
        >expand All</LteButton
      >
      <LteButton on:click={thisTree.changeAllExpansion(false)}
        >colapse All</LteButton
      >
      <Checkbox bind:checked={checkboxes} id="checkboxes"
        ><Label inputId="checkboxes">checkboxes</Label>
      </Checkbox>
      {#if checkboxes}
        <div style="margin-left: 2em;">
          <Checkbox bind:checked={recursive} id="recursive"
            ><Label inputId="recursive">recursive</Label>
          </Checkbox>
          <Checkbox
            bind:checked={leafNodeCheckboxesOnly}
            id="leafNodeCheckboxesOnly"
            ><Label inputId="leafNodeCheckboxesOnly"
              >leafNodeCheckboxesOnly</Label
            >
          </Checkbox>
          <Checkbox bind:checked={disableOrHide} id="disableOrHide"
            ><Label inputId="disableOrHide">disableOrHide</Label></Checkbox
          >
          <Checkbox bind:checked={recalculateNodePath} id="recalculateNodePath"
            ><Label inputId="recalculateNodePath">recalculateNodePath</Label></Checkbox
          >
        </div>
      {/if}

      <Checkbox bind:checked={dragAndDrop} id="dragAndDrop"
        ><Label inputId="dragAndDrop">dragAndDrop</Label>
      </Checkbox>
      {#if dragAndDrop}
        <div style="margin-left: 2em;">
          <NumberInput bind:value={timeToNest}></NumberInput>

          <NumberInput bind:value={pixelNestTreshold}></NumberInput>

        </div>
      {/if}
      <Checkbox bind:checked={showContexMenu} id="showContexMenu"
        ><Label inputId="showContexMenu">showContexMenu</Label>
      </Checkbox>
      <Checkbox bind:checked={enableVerticalLines} id="enableVerticalLines"
        ><Label inputId="enableVerticalLines">enableVerticalLines</Label>
      </Checkbox>
      <NumberInput bind:value={expandedLevel}></NumberInput>
    </Card>
  </dir>
  <!-- <dir class="row-4"></dir> -->
</div>

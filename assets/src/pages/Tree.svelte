<script>
  import {
    PageHeader,
    BreadcrumbItem,
    Card,
    Checkbox,
    LteButton,
    NumberInput,
  } from "svelte-adminlte";
  import { _ } from "svelte-i18n";
  import { TreeView } from "svelte-treeview";
  import MenuOption from "svelte-treeview/src/MenuOption.svelte";
  import MenuDivider from "svelte-treeview/src/MenuDivider.svelte";
  import { onMount } from "svelte";
  import Label from "svelte-adminlte/src/form/structure/Label.svelte";

  let tree = [
//1
    { nodePath: "1", hasChildren: true, title: "Strength" },
    { nodePath: "1.1", title: " Abbadon" },
    { nodePath: "1.2", title: " Axe" },
    { nodePath: "1.3", title: " Mars" },
    { nodePath: "1.4", title: " Tusk" },
//2
    { nodePath: "2", hasChildren: true, title: "Agility"  },
    { nodePath: "2.1", title: " Juggernaut" },
    { nodePath: "2.2", title: " Gyrocopter" },
    { nodePath: "2.3", title: " Lone Druid" },
    { nodePath: "2.4", title: " Sniper" },
    { nodePath: "2.5", title: " Viper" },
//3
    { nodePath: "3", hasChildren: true, title: "Intelligence"  },
    { nodePath: "3.1", title: " Dazzle" },
    { nodePath: "3.2", title: " Chen" },
    { nodePath: "3.3", title: " Lion" },
    { nodePath: "3.4", title: " Techies" },
    { nodePath: "3.5", title: " Void Spirit" },
//4
    // { nodePath: "4", hasChildren: true, title: " TEST0" },
    // { nodePath: "4.1", title: " TEST1"},
    // { nodePath: "4.2", hasChildren: true , title: " TEST2"},
    // { nodePath: "4.2.1" , title: " TEST3"},
    // { nodePath: "4.2.2" , title: " TEST4"},
    // { nodePath: "4.2.3" , title: " TEST5"},
    // { nodePath: "4.2.4" , title: " TEST6"},
    // { nodePath: "4.3" , title: " TEST7"},
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
    expandedLevel = 0,
    showNodes = false;

  function handleClick(node) {
    tree = tree.filter((n) => n.nodePath != node.nodePath);
  }
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
        {timeToNest}
        {pixelNestTreshold}
        {showContexMenu}
        {enableVerticalLines}
        {recalculateNodePath}
        {expandedLevel}
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
            on:click={alert(JSON.stringify(node))}
          />
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
      <Checkbox bind:checked={showNodes} id="showNodes"
        ><Label inputId="showNodes">showNodes</Label>
      </Checkbox>

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
            ><Label inputId="recalculateNodePath">recalculateNodePath</Label
            ></Checkbox
          >
        </div>
      {/if}

      <Checkbox bind:checked={dragAndDrop} id="dragAndDrop"
        ><Label inputId="dragAndDrop">dragAndDrop</Label>
      </Checkbox>
      {#if dragAndDrop}
        <div style="margin-left: 2em;">
          <NumberInput bind:value={timeToNest} />

          <NumberInput bind:value={pixelNestTreshold} />
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
  </dir>
  <!-- <dir class="row-4"></dir> -->
</div>

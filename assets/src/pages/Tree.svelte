<script>
	import {
		PageHeader,
		BreadcrumbItem,
		Card,
		Checkbox,
		LteButton,
		NumberInput,
		Label,
		FormGroup,
	} from "@keenmate/svelte-adminlte";
	import { _ } from "svelte-i18n";
	import { TreeView } from "svelte-treeview";
	import MenuOption from "svelte-treeview/src/MenuOption.svelte";
	import MenuDivider from "svelte-treeview/src/MenuDivider.svelte";
	import { onMount } from "svelte";
	import treeProvider from "../providers/treeProvider";
	import formatHighlight from "json-format-highlight";
	import SvelteMarkdown from "svelte-markdown";

	let tree = [];
	let recursive = false,
		checkboxes = false,
		leafNodeCheckboxesOnly = false,
		checkboxesDisabled = false,
		thisTree,
		dragAndDrop = true,
		timeToNest = null,
		pixelNestTreshold = 150,
		showContexMenu = true,
		enableVerticalLines = false,
		recalculateNodePath = true,
		expandedLevel = 0,
		showNodes = false,
		events = [],
		showConsole = false;

	const propNames = {
		nodePath: "nodePath",
		hasChildren: "hasChildren",
		isDraggable: "isDraggable",
		nestDisabled: "nestDisabled",
		insertDisabled: "insertDisabled",
	};

	function handleClick(node) {
		console.log("deleting: " + node.nodePath);
		tree = tree.filter((n) => n.nodePath != node.nodePath);
	}

	function handleEvent(e, t) {
		if (!t) return;
		events.push({ detail: e.detail, type: t });
		events = events;
	}

	function loadInitialTree() {
		treeProvider
			.getTree()
			.then((res) => {
				console.log(res.data);
				if (res.data.length) tree = res.data;
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
		if (targetNode?.nodePath?.startsWith("4")) {
			let teamNodeParth = targetNode?.nodePath.slice(0, 3);

			let count = tree.filter((n) =>
				n.nodePath.startsWith(teamNodeParth)
			)?.length;
			console.log(count);
			if (!(count <= 5)) {
				alert("You can have max 5 heroes in one team");
				return false;
			}
		}
		return true;
	}

	function dragEnterCallback(movedNode, oldParent, targetNode) {
		console.log(
			!targetNode?.nodePath?.startsWith("4") &&
				movedNode?.type != targetNode?.type
		);
		if (
			!targetNode?.nodePath?.startsWith("4") &&
			movedNode?.type != targetNode?.type
		)
			return false;
		// console.log(`dragEnterCallback called entered ${TargetNode.nodePath}`)
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
	<div class="col-12">
		<Card>
			<SvelteMarkdown source={$_("tree.text")} />
		</Card>
	</div>
</div>

<div class="row">
	<div
		class:col-lg-8={!showConsole}
		class:col-lg-4={showConsole}
		class="col-md-12"
	>
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
				checkboxes={checkboxes ? "all" : "none"}
				{leafNodeCheckboxesOnly}
				{checkboxesDisabled}
				{dragAndDrop}
				{timeToNest}
				{pixelNestTreshold}
				{showContexMenu}
				{enableVerticalLines}
				{recalculateNodePath}
				{expandedLevel}
				beforeMovedCallback={callback}
				{propNames}
				{dragEnterCallback}
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
	</div>

	<div class="col-lg-4 col-md-12">
		<Card>
			<svelte:fragment slot="header">
				{$_("tree.options")}
			</svelte:fragment>
			<LteButton on:click={loadInitialTree}>reset tree</LteButton>
			<Checkbox bind:checked={showConsole} id="showConsole"
				><Label inputId="showConsole">Show console</Label>
			</Checkbox>
			<Checkbox bind:checked={showNodes} id="showNodes"
				><Label inputId="showNodes">showNodes</Label>
			</Checkbox>

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
					{#if recursive}
						<div style="margin-left: 2em;">
							<Checkbox
								bind:checked={leafNodeCheckboxesOnly}
								id="leafNodeCheckboxesOnly"
								><Label inputId="leafNodeCheckboxesOnly"
									>leafNodeCheckboxesOnly</Label
								>
							</Checkbox>
							<Checkbox
								bind:checked={checkboxesDisabled}
								id="checkboxesDisabled"
								><Label inputId="checkboxesDisabled">checkboxesDisabled</Label
								></Checkbox
							>
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
						></Checkbox
					>
				</div>
			{/if}
			<Checkbox bind:checked={showContexMenu} id="showContexMenu"
				><Label inputId="showContexMenu">showContexMenu</Label>
			</Checkbox>
			<Checkbox bind:checked={enableVerticalLines} id="enableVerticalLines"
				><Label inputId="enableVerticalLines">enableVerticalLines</Label>
			</Checkbox>
			<FormGroup>
				<Label>expandedLevel</Label>
				<NumberInput bind:value={expandedLevel} />
			</FormGroup>
		</Card>
	</div>

	{#if showConsole}
		<div class="col-lg-4 col-md-12">
			<Card>
				<svelte:fragment slot="header">
					{$_("tree.events")}
				</svelte:fragment>
				<div class="mh80">
					{#each events as ev}
						<ul class="ul">
							<li>
								<b>{ev.type}</b> <br />
								<code>{@html formatHighlight(ev.detail)}</code>
							</li>
						</ul>
					{/each}
				</div>
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
	.mh80 {
		max-height: 70vh;
		overflow-y: scroll;
	}

	:global(.treeview ul li:before) {
		top: 1em;
	}
</style>

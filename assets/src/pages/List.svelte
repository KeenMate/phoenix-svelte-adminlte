<script>
  import  sortBy from "lodash/sortBy";
  import maxBy  from "lodash/maxBy";
  import { Sortable, MultiDrag } from "sortablejs";
  import { onMount } from "svelte";
  import { _ } from "svelte-i18n";
  import {
    Card,
    Callout,
    LteButton,
    PageHeader,
    DraggableContainer,
    BreadcrumbItem
  } from "svelte-adminlte";
  import CreateCarModal from "../components/list/CreateCarModal.svelte";
  import { bind } from "svelte/internal";

  const initialItems = [
    {
      manufacturer: "Lexus",
      model: "LS",
      year: 2018,
    },
    {
      manufacturer: "Aston Martin",
      model: "Vantage",
      year: 2020,
    },
    {
      manufacturer: "McLaren",
      model: "P1",
      year: 2016,
    },
    {
      manufacturer: "Alfa Romeo",
      model: "Giulietta",
      year: 2012,
    },
    {
      manufacturer: "Bugatti",
      model: "Chiron",
      year: 2018,
    },
  ];

  onMount(() => {
    try {
      Sortable.mount(new MultiDrag());
    } catch (err) {}

    initialItems.forEach((car) => addCar(car));
  });

  let items = [];
  let order = [];

  let listElement;
  let sortable;

  let showCreateCar;

  const store = {
    set(sortable) {
      recalculateOrder(sortable, items);
    },
  };

  $: {
    if (listElement) {
      sortable = new Sortable(listElement, {
        store,
        multiDrag: true,
        selectedClass: "draggable-selected",
        draggable: ".draggable-callout",
        handle: ".draggable-handle",
        animation: 150,
      });
    }
  }

  $: sortable && recalculateOrder(sortable, items);

  function recalculateOrder(sortable, items) {
    order = sortable.toArray().map((id, index) => {
      const item = items.find((i) => i.id === Number(id));

      return {
        currentIndex: index,
        title: `${item.manufacturer} ${item.model}`,
      };
    });
  }

  function addCar(car) {
    let maxIndexItem = maxBy(items, "id");

    let newItemIndex = maxIndexItem ? maxIndexItem.id + 1 : 0;
    items.push({
      id: newItemIndex,
      manufacturer: car.manufacturer,
      model: car.model,
      year: car.year,
    });

    items = items;
    order = order;
  }
</script>

<!-- Favorite cars (top 5) - manufacturer, model -->
<!-- Add, remove, edit functionality-->

<PageHeader>{$_("list.title")} <small>Change order</small>
  <svelte:fragment slot="breadcrumbs">
    <BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
    <BreadcrumbItem active>{$_("list.title")}</BreadcrumbItem>
  </svelte:fragment>
</PageHeader>

<div class="row">
  <div class="col-lg-9 col-md-12 order-md-1 order-lg-0">
    <Card outline color="primary">
      <svelte:fragment slot="header">Favorite cars</svelte:fragment>

      <LteButton
        slot="tools"
        color="success"
        small
        on:click={() => showCreateCar()}
      >
        <i class="fas fa-plus" />
      </LteButton>

      <DraggableContainer bind:listElement bind:items>
        <svelte:fragment let:item = {item}>
          <div class="row">Manufacturer: {item.manufacturer}</div>
          <div class="row">Model: {item.model}</div>
          <div class="row">Year: {item.year || "all"}</div>
        </svelte:fragment>
      </DraggableContainer>
    </Card>
  </div>
  <div class="col-lg-3 col-md-12 order-md-0 order-lg-1">
    <Card>
      <svelte:fragment slot="header">Current order</svelte:fragment>

      <ul>
        {#each sortBy(order, ["currentIndex"]) as item}
          <li>{item.currentIndex} {item.title}</li>
        {/each}
      </ul>
    </Card>
  </div>

  <CreateCarModal
    bind:openModal={showCreateCar}
    on:add={({ detail: car }) => addCar(car)}
  />
</div>

<style lang="scss">
  :global {
    .draggable-selected > .callout {
      background-color: rgba(255, 0, 0, 0.2);
    }
  }
</style>

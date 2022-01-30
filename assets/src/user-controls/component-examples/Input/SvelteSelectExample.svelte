<script>
  import ComponentPageTemplate from "../../../components/component-templates//ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import SvelteSelect from "svelte-select";

  let data = {
    text: "*We are not authors of this component, but we use it with svelte-adminlte so we created this page with basic examples for our own usage. [Link](https://github.com/rob-balfre/svelte-select) to component repo.*",
    props: [
      { name: "items", type: "Array", comment: "List of selectable items that appear in the dropdown" },
      { name: "value", type: "Any", comment: "Selected item or items." },
      { name: "filterText", type: "String", comment: "Text to filter items by." },
      { name: "isCreatable", type: "Boolean", comment: "Can create new item(s) to be added to value" },
      { name: "hasError", type: "Boolean", comment: "Show/hide error styles around select input (red border by default)." },
      { name: "isMulti", type: "Boolean ", comment: "Enable multi-select, value becomes an array of selected items." },
      { name: "loadOptions", type: "function that returns a Promise", comment: "To load items asynchronously then loadOptions is the simplest solution. Supply a function that returns a Promise that resolves with a list of items. loadOptions has debounce baked in and fires each time filterText is updated." },
      { name: "", type: "", comment: "" },
      { name: "", type: "", comment: "" },
    ],
    events: [
      { name: "select", comment: "fired when user selects option", params: "selected item" },
      { name: "clear", comment: "fired when user clicks on **x**", params: "" },
      { name: "loaded", comment: "fires when loadOptions resolves", params: "items" },
    ],
    examples: {
      basic: {
        name: "Basic usage",
        code: "<SvelteSelect\r\nitems={options}\r\nbind:value = {value1}\r\n/>",
      },
      multi: {
        name: "Multiselect that doesnt automatically close",
        code: "let listOpen,isFocused;\r\n$: {\r\n    if (!listOpen && isFocused) listOpen = true;\r\n  }\r\n\r\n...\r\n\r\n<SvelteSelect\r\nbind:listOpen\r\nbind:isFocused\r\nitems={options}\r\nisMulti\r\nisCreatable\r\n/>",
      },
    },
  };

  let options = [
    "Mercedes",
    "Alpine",
    "Haas F1 Team",
    "Red Bull Racing",
    "McLaren",
    "Aston Martin",
    "Ferrari",
    "AlphaTauri",
    "Alfa Romeo",
    "Williams",
  ];
  let value1, value2, value3;
  let listOpen, isFocused;
  $: {
    if (!listOpen && isFocused) listOpen = true;
  }
</script>

<ComponentPageTemplate
  text={data.text}
  properties={data.props}
  events={data.events}
>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.basic.code}
      name={data.examples.basic.name}
    >
      <SvelteSelect items={options} bind:value={value1} />
      {value1 ? JSON.stringify(value1) : ""}
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.multi.code}
      name={data.examples.multi.name}
    >
      <SvelteSelect
        bind:listOpen
        bind:isFocused
        items={options}
        isMulti
        bind:value={value2}
      />
      {value2 ? JSON.stringify(value2) : ""}
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

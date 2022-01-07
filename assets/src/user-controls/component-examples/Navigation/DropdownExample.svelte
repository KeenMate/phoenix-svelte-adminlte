<script>
  import ComponentPageTemplate from "../../../components/component-templates//ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import {Dropdown,DropdownMenu,DropdownItem,DropdownButton} from 'svelte-adminlte';
  let data = {
    text: "Dropdown with links. More info on [Bootstrap.com](https://getbootstrap.com/docs/4.0/components/dropdowns/). ",
    props: [{ name: "", type: "", comment: "" }],
    events: [{ name: "", comment: "", params: "" }],
    examples: {
      minimal: {
        name: "dropdown usage example",
        code: "<Dropdown >\r\n  <DropdownButton href=\"url\">items<\/DropdownButton>\r\n  <DropdownMenu>\r\n        <DropdownItem href=\"url\">Item1<\/DropdownItem>\r\n        <DropdownItem href=\"url\">Item2<\/DropdownItem>\r\n        <DropdownItem href=\"url\">Item3<\/DropdownItem>\r\n        <DropdownItem href=\"url1\">Item4<\/DropdownItem>\r\n  <\/DropdownMenu>\r\n<\/Dropdown>",
      },
    },
  };
</script>

<ComponentPageTemplate
  text={data.text}
>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.minimal.code}
      name={data.examples.minimal.name}
      codeonly
      >
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

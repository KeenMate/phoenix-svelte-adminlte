<script>
  import ComponentPageTemplate from "../controls/Components/ComponentPageTemplate.svelte";
  import ComponentExample from "../controls/Components/ComponentExample.svelte";

  let testComponent = {
    name: "Input",
    text: "Component is used for user input. It can be used for multiple types of input",
    props: [{ name: "type", type: "string", comment: "indicates inpur type" },{ name: "value", type: "string", comment: "value of input" }],
    examples: [
      {
        code: "<script>\r\nlet a = \"\";\r\n<\/script>\r\n\r\n<input type=\"text\" bind:value={a}\/>",
        name: "Variable binded to input's value",
      },
      {
        code: "<input type=\"text\" on:change={() => alert(\"input changed\")} \/>",
        name: "alert fired on change",
      },
    ],
  };

  let a = "";
</script>

<ComponentPageTemplate
  name={testComponent.name}
  text={testComponent.text}
  properties={testComponent.props}
  ><svelte:fragment slot="examples">
    <div class="row">
      <ComponentExample
        code={testComponent.examples[0].code}
        name={testComponent.examples[0].name}
      >
        <input type="text" bind:value={a} />
        <br />{a}</ComponentExample
      >
      <ComponentExample
        code={testComponent.examples[0].code}
        name={testComponent.examples[0].name}
      >
        <input type="text" on:change={() => alert("input changed")} /></ComponentExample
      >
    </div>
  </svelte:fragment></ComponentPageTemplate
>

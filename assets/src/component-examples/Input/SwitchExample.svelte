<script>
  import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";

  import { Switch, FormGroup } from "svelte-adminlte";
  let data = {
    name: "Switch Example",
    text: "",
    props: [
      { name: "checked", type: "string", comment: "" },
      {
        name: "checkedClass",
        type: "string",
        comment:
          "Use classes that add backgroud-color (bg-red ,bg-primary, atd.).",
      },
      {
        name: "uncheckedClass",
        type: "string",
        comment:
          "Use classes that add backgroud-color (bg-red ,bg-primary, atd.).",
      },
    ],
    events: [{ name: "click", comment: "", params: "" }],
    examples: {
      minimal: {
        name: "usage",
        code: "<Switch bind:value={checked} />",
      },
      color: {
        name: "colors",
        code: '<FormGroup>\r\n        bg-green<Switch  checkedClass="bg-green" uncheckedClass="bg-red" bind:checked={checked} />\r\n      </FormGroup>\r\n      <FormGroup>\r\n        bg-blue<Switch  checkedClass="bg-blue" uncheckedClass="bg-gray" bind:checked={checked} />\r\n      </FormGroup>\r\n      <FormGroup>\r\n        bg-primary<Switch  checkedClass="bg-primary" uncheckedClass="bg-gray" bind:checked={checked} />\r\n      </FormGroup>\r\n      <FormGroup>\r\n        bg-success<Switch  checkedClass="bg-success" uncheckedClass="bg-gray" bind:checked={checked} />\r\n      </FormGroup>\r\n      <FormGroup>\r\n        bg-danger<Switch  checkedClass="bg-danger" uncheckedClass="bg-gray" bind:checked={checked} />\r\n      </FormGroup>\r\n      <FormGroup>\r\n        bg-warning<Switch  checkedClass="bg-warning" uncheckedClass="bg-gray" bind:checked={checked} />\r\n      </FormGroup>\r\n      <FormGroup>\r\n        bg-info<Switch  checkedClass="bg-info" uncheckedClass="bg-gray" bind:checked={checked} />\r\n      </FormGroup>\r\n      <FormGroup>\r\n        bg-light<Switch  checkedClass="bg-light" uncheckedClass="bg-gray" bind:checked={checked} />\r\n      \r\n      </FormGroup>\r\n      <FormGroup>\r\n          bg-dark<Switch  checkedClass="bg-dark" uncheckedClass="bg-gray" bind:checked={checked} />\r\n        </FormGroup>\r\n        <FormGroup>\r\n          bg-white<Switch  checkedClass="bg-white" uncheckedClass="bg-gray" bind:checked={checked} />\r\n      \r\n        </FormGroup> ',
      },
    },
  };

  let checked;
</script>

<ComponentPageTemplate
  text={data.text}
  properties={data.props}
  events={data.events}
>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.minimal.code}
      name={data.examples.minimal.name}
    >
      <Switch bind:checked />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.color.code}
      name={data.examples.color.name}
    >
      <FormGroup>
        bg-green<Switch
          checkedClass="bg-green"
          uncheckedClass="bg-red"
          bind:checked
        />
      </FormGroup>
      <FormGroup>
        bg-blue<Switch checkedClass="bg-blue" bind:checked />
      </FormGroup>
      <FormGroup>
        bg-primary<Switch
          checkedClass="bg-primary"
          uncheckedClass="bg-gray"
          bind:checked
        />
      </FormGroup>
      <FormGroup>
        bg-success<Switch
          checkedClass="bg-success"
          uncheckedClass="bg-gray"
          bind:checked
        />
      </FormGroup>
      <FormGroup>
        bg-danger<Switch
          checkedClass="bg-danger"
          uncheckedClass="bg-gray"
          bind:checked
        />
      </FormGroup>
      <FormGroup>
        bg-warning<Switch
          checkedClass="bg-warning"
          uncheckedClass="bg-gray"
          bind:checked
        />
      </FormGroup>
      <FormGroup>
        bg-info<Switch
          checkedClass="bg-info"
          uncheckedClass="bg-gray"
          bind:checked
        />
      </FormGroup>
      <FormGroup>
        bg-light<Switch
          checkedClass="bg-light"
          uncheckedClass="bg-gray"
          bind:checked
        />
      </FormGroup>
      <FormGroup>
        bg-dark<Switch
          checkedClass="bg-dark"
          uncheckedClass="bg-gray"
          bind:checked
        />
      </FormGroup>
      <FormGroup>
        bg-white<Switch
          checkedClass="bg-white"
          uncheckedClass="bg-gray"
          bind:checked
        />
      </FormGroup>
    </ComponentExampleTemplate>
  </svelte:fragment>
</ComponentPageTemplate>

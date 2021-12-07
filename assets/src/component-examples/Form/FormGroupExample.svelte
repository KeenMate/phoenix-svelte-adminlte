<script>
  import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";

  import { FormGroup, Label, TextInput } from "svelte-adminlte";

  let data = {
    name: "FormGroup",
    text: "",
    props: [
      {
        name: "row",
        type: "bool",
        comment: "If true it adds row class. Default is false.",
      },
      { name: "class", type: "string", comment: "" },
    ],
    slots: [{ name: "[detail]", comment: "insides of FormGroup", params: "" }],
    examples: {
      minimal: {
        name: "minimal",
        code: "<FormGroup>\r\n  <Label>label<\/Label>\r\n  <TextInput \/>\r\n<\/FormGroup>\r\n<FormGroup>\r\n  <Label>label<\/Label>\r\n  <TextInput \/>\r\n<\/FormGroup>",
      },
      row: {
        name: "row",
        code: "<FormGroup row>\r\n  <Label>label<\/Label>\r\n  <TextInput \/>\r\n<\/FormGroup>\r\n<FormGroup row>\r\n  <Label>label<\/Label>\r\n  <TextInput \/>\r\n<\/FormGroup>",
      },
    },
  };
</script>

<ComponentPageTemplate
  text={data.text}
  properties={data.props}
  slots={data.slots}
>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.minimal.code}
      name={data.examples.minimal.name}
    >
      <FormGroup>
        <Label>label</Label>
        <TextInput />
      </FormGroup>
      <FormGroup>
        <Label>label</Label>
        <TextInput />
      </FormGroup>
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.row.code}
      name={data.examples.row.name}
    >
      <FormGroup row>
        <Label>label</Label>
        <TextInput />
      </FormGroup>
      <FormGroup row>
        <Label>label</Label>
        <TextInput />
      </FormGroup>
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

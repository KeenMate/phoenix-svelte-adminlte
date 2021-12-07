<script>
  import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";

  import { Form, Label, TextInput, FormGroup } from "svelte-adminlte";

  let data = {
    name: "Form",
    text: "",
    props: [
      {
        name: "form",
        type: "",
        comment: "Used to apply felte plugin to form.",
      },
      {
        name: "horizontal",
        type: "bool",
        comment:
          "If true, form is horizontal. False is the default. I think it **doesnt work**.",
      },
      { name: "class", type: "string", comment: "class applied to <form>" },
      {
        name: "...$$restProps",
        type: "",
        comment: "Every prop you add will be applied to form",
      },
    ],
    slots: [{ name: "[default]", comment: "content of form", params: "" }],
    examples: {
      minimal: {
        name: "Minimal",
        code: '<Form>\r\n  <FormGroup>\r\n    <Label>label<\/Label>\r\n    <TextInput \/>\r\n  <\/FormGroup>\r\n<\/Form>',
      },
      horizontal: {
        name: "Horizontal (doesnt seem to work )",
        code: '<Form horizontal>\r\n  <FormGroup>\r\n    <Label>label<\/Label>\r\n    <TextInput \/>\r\n  <\/FormGroup>\r\n<\/Form>',
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
      <Form>
        <FormGroup>
          <Label inputId="inputId">label</Label>
          <TextInput />
        </FormGroup>
      </Form>
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.horizontal.code}
      name={data.examples.horizontal.name}
    >
      <Form horizontal>
        <FormGroup>
          <Label inputId="inputId">label</Label>
          <TextInput />
        </FormGroup>
      </Form>
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

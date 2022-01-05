<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import {
    InputGroup,
    InputGroupAppend,
    InputGroupPrepend,
    LteButton,
    TextInput,
    Textarea,
    Checkbox,
    Label,
  } from "svelte-adminlte";

  let data = {
    name: "",
    text: "Use *.input-group-text* for controls that are not same size",
    props: [
      {
        name: "text",
        type: "bool",
        comment:
          "set true for **InputGroupAppend** and **InputGroupPrepend** if you want to use element that isnt full size.",
      },
      { name: "class", type: "string", comment: "" },
    ],
    slots: [{ name: "[detail]", comment: "insides of FormGroup", params: "" }],

    examples: {
      append: {
        name: "InputGroupAppend",
        code: "<InputGroup>\r\n  <TextInput \/>\r\n  <InputGroupAppend><LteButton small>button<\/LteButton><\/InputGroupAppend>\r\n<\/InputGroup>",
      },
      prepend: {
        name: "InputGroupPrepend",
        code: "<InputGroup>\r\n  <InputGroupPrepend>\r\n    <LteButton small>button<\/LteButton>\r\n  <\/InputGroupPrepend>\r\n  <TextInput \/>\r\n<\/InputGroup>",
      },
      text: {
        name: "Static text",
        code: "<InputGroup>\r\n  <InputGroupPrepend text>static text<\/InputGroupPrepend>\r\n  <TextInput \/>\r\n<\/InputGroup>",
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
      code={data.examples.append.code}
      name={data.examples.append.name}
    >
<InputGroup>
  <TextInput />
  <InputGroupAppend><LteButton small>button</LteButton></InputGroupAppend>
</InputGroup>
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.prepend.code}
      name={data.examples.prepend.name}
    >
<InputGroup>
  <InputGroupPrepend>
    <LteButton small>button</LteButton>
  </InputGroupPrepend>
  <TextInput />
</InputGroup>
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.text.code}
      name={data.examples.text.name}
    >
<InputGroup>
  <InputGroupPrepend text>static text</InputGroupPrepend>
  <TextInput />
</InputGroup>
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

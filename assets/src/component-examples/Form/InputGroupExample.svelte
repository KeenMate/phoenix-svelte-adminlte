<script>
  import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";

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
    props: [{ name: "class", type: "string", comment: "" }],
    slots: [{ name: "[detail]", comment: "insides of FormGroup", params: "" }],

    examples: {
      minimal: {
        name: "InputGroup",
        code: "<InputGroup>\r\n  <TextInput />\r\n  <LteButton small>button</LteButton>\r\n</InputGroup>",
      },
      append: {
        name: "InputGroupAppend",
        code: "<InputGroup>\r\n  <InputGroupPrepend>\r\n    <LteButton small>button</LteButton>\r\n  </InputGroupPrepend>\r\n  <TextInput />\r\n</InputGroup>",
      },
      prepend: {
        name: "InputGroupPrepend",
        code: '<InputGroup>\r\n  <Textarea />\r\n  <InputGroupAppend>\r\n    <div class="input-group-text">\r\n      <Checkbox id="valueInputa"><Label inputId="valueInputa" /></Checkbox\r\n      >\r\n    </div>\r\n  </InputGroupAppend>\r\n</InputGroup>',
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
      <InputGroup>
        <TextInput />
        <LteButton small>button</LteButton>
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
      code={data.examples.append.code}
      name={data.examples.append.name}
    >
      <InputGroup>
        <Textarea />
        <InputGroupAppend>
          <div class="input-group-text">
            <Checkbox id="valueInputa"><Label inputId="valueInputa" /></Checkbox
            >
          </div>
        </InputGroupAppend>
      </InputGroup>
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

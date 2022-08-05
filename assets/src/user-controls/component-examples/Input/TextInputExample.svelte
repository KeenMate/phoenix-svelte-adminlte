<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import { TextInput ,Label} from "@keenmate/svelte-adminlte";
  import SvelteSelect from "svelte-select";

  let data = {
    name: "TextInput",
    text: "Component is used for user input. It can be used for multiple types of input",
    props: [
      { name: "id", type: "string", comment: "" },
      { name: "value", type: "string", comment: "" },
      { name: "name", type: "string", comment: "" },
      { name: "placeholder", type: "string", comment: "" },
      { name: "pattern", type: "regex", comment: "" },
      { name: "readonly", type: "bool ", comment: "false is default" },
      { name: "disabled", type: "bool", comment: "false is default" },
      { name: "inputMask", type: "string", comment: "" },
      { name: "invalid", type: "bool", comment: "false is default" },
      { name: "size", type: "sm|md|lg", comment: "sets size of input" },
      {
        name: "inputElement",
        type: "",
        comment: "you can direcly acces input through this",
      },
    ],
    events: [
      {
        name: "keypress",
        type: "",
        comment: "event fires everytime user times into input",
      },
    ],
    examples: {
      minimal: {
        name: "Minimal TextInput usage",
        code: "<TextInput bind:value={value}/>",
      },
      basic: {
        name: "TextInput basic usage",
        code: '<TextInput bind:value={value} id="inputId" name="inputName" placeholder="Type something..."/>',
      },
      pattern: {
        name: "TextInput with pattern",
        code: '<TextInput bind:value={c} id="inputId" name="inputName" placeholder="Type 3 letter countrycode..." inputMask="99/99/9999"/>',
      },
      sizes:{
        name: "Sizes"
      }
    },
  };

  let a = "",
    b = "",
    c = "",
    d = "",
    size = "lg";
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
      <TextInput bind:value={a} />
      {a}
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.basic.code}
      name={data.examples.basic.name}
    >
      <TextInput
        bind:value={b}
        id="inputId"
        name="inputName"
        placeholder="Type something..."
      />
      {b}
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.pattern.code}
      name={data.examples.pattern.name}
    >
      <TextInput
        bind:value={c}
        id="inputId"
        name="inputName"
        placeholder="Type 3 letter countrycode..."
        inputMask="'mask': '99-9999999'"
      />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      name={data.examples.sizes.name}
      exampleOnly
    >
      <Label>sm</Label>
      <TextInput size="sm" placeholder={"size=\"sm\""} />
      <Label>md</Label> 
      <TextInput size="md" placeholder={"size=\"md\""}/>
      <Label>lg</Label>
      <TextInput size="lg" placeholder={"size=\"lg\""} />
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import { NumberInput, InputGroup, TextInput ,Label} from "svelte-adminlte";
  let data = {
    name: "NumberInput",
    text: "Input with type number",
    props: [
      { name: "id", type: "string", comment: "" },
      { name: "value", type: "string", comment: "" },
      { name: "name", type: "string", comment: "" },
      { name: "placeholder", type: "string", comment: "" },
      { name: "pattern", type: "string", comment: "" },
      { name: "readonly", type: "bool", comment: "" },
      { name: "disabled", type: "bool", comment: "" },
      { name: "inputMask", type: "string", comment: "" },
      { name: "invalid", type: "bool", comment: "" },
      { name: "inputElement", type: "element", comment: "" },
      { name: "min", type: "number", comment: "" },
      { name: "max", type: "number", comment: "" },
    ],
    examples: {
      minimal: {
        name: "Minimal usage",
        code: "<NumberInput bind:value />",
      },
      basic: {
        name: "Basic usage",
        code: '<NumberInput bind:value name="number-input" id="number-input" placeholder="Click to start typing..."/>',
      },
      minmax: {
        name: "Min max",
        code: '<InputGroup class="mb-2">\r\n  <TextInput bind:value={min} placeholder="min"/>\r\n  <TextInput bind:value={max} placeholder="max"/>\r\n</InputGroup>\r\n  <NumberInput bind:value = {value3} name="number-input" \r\n  id="number-input" placeholder="Enter number..."\r\n  {min} {max}/>',
      },
      sizes:{
        name:"Sizes"
      }
    },
  };
  let value1,
    value2,
    value3,
    min = 1,
    max = 5;
</script>

<ComponentPageTemplate text={data.text} properties={data.props}>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.minimal.code}
      name={data.examples.minimal.name}
    >
      <NumberInput bind:value={value1} />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.basic.code}
      name={data.examples.basic.name}
    >
      <NumberInput
        bind:value={value2}
        name="number-input"
        id="number-input"
        placeholder="Click to start typing..."
      />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.minmax.code}
      name={data.examples.minmax.name}
    >
      <InputGroup class="mb-2">
        <TextInput bind:value={min} placeholder="min" />
        <TextInput bind:value={max} placeholder="max" />
      </InputGroup>
      <NumberInput
        bind:value={value3}
        name="number-input"
        id="number-input"
        placeholder="Enter number..."
        {min}
        {max}
      />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
    name={data.examples.sizes.name}
    exampleOnly
  >
    <Label>sm</Label>
    <NumberInput size="sm" placeholder={"size=\"sm\""} />
    <Label>md</Label> 
    <NumberInput size="md" placeholder={"size=\"md\""}/>
    <Label>lg</Label>
    <NumberInput size="lg" placeholder={"size=\"lg\""} />
  </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

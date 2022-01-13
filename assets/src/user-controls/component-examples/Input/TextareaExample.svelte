<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import { Textarea, TextInput, InputGroup,Label } from "svelte-adminlte";
  let data = {
    name: "",
    text: "",
    props: [
      { name: "id", type: "string", comment: "" },
      { name: "value", type: "string", comment: "" },
      { name: "name", type: "string", comment: "" },
      { name: "rows", type: "number", comment: "" },
      { name: "columns", type: "number", comment: "" },
      { name: "placeholder", type: "string", comment: "" },
      { name: "pattern", type: "string", comment: "" },
      { name: "readonly", type: "bool", comment: "" },
      { name: "disabled", type: "bool", comment: "" },
      { name: "maxlength", type: "number", comment: "" },
    ],
    examples: {
      minimal: {
        name: "Minimal",
        code: "<Textarea bind:value/>",
      },
      basic: {
        name: "Basic",
        code: '<Textarea bind:value id="textarea" name="textare" rows={5} placeholder="start typing.."/>',
      },
      maxlength: {
        name: "Max length",
        code: '<Textarea\r\n  bind:value = {value3}\r\n  maxlength = {8}\r\n  id="textarea"\r\n  name="textare"\r\n  placeholder="start typing.."\r\n/>',
      },
      size: {
        name: "Cols and Rows",
        code: '<InputGroup class="mb-2">\r\n  <TextInput bind:value={cols} placeholder="columns"/>\r\n  <TextInput bind:value={rows} placeholder="rows"/>\r\n</InputGroup>\r\n\r\n<Textarea bind:value = {value4} id="textarea" name="textare"\r\n  placeholder="start typing.." {cols} {rows}\r\n/>',
      },
      color: {
        name: "Border color based on value length",
        code: '<Textarea\r\n  bind:value = {value5}\r\n  id="textarea"\r\n  name="textare"\r\n  placeholder="start typing.."\r\n  class={border}\r\n/>',
      },
      sizes:{
        name:"Sizes"
      }
    },
  };

  function getclass(v) {
    if (v) {
      let l = v.length;
      if (l > 0) {
        if (l > 8) {
          if (l > 12) {
            return "border border-danger";
          }
          return "border border-warning";
        }
        return "border border-primary";
      }
    }
  }

  let border = null;

  $: border = getclass(value5);

  let rows, cols;
  let value1, value2, value3, value4, value5;
</script>

<ComponentPageTemplate text={data.text} properties={data.props}>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.minimal.code}
      name={data.examples.minimal.name}
    >
      <Textarea bind:value={value1} />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.basic.code}
      name={data.examples.basic.name}
    >
      <Textarea
        bind:value={value2}
        id="textarea"
        name="textare"
        placeholder="start typing.."
      />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.maxlength.code}
      name={data.examples.maxlength.name}
    >
      <Textarea
        bind:value={value3}
        maxlength={8}
        id="textarea"
        name="textare"
        placeholder="start typing.."
      />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.size.code}
      name={data.examples.size.name}
    >
      <InputGroup class="mb-2">
        <TextInput bind:value={cols} placeholder="columns" />
        <TextInput bind:value={rows} placeholder="rows" />
      </InputGroup>

      <Textarea
        bind:value={value4}
        id="textarea"
        name="textare"
        placeholder="start typing.."
        {cols}
        {rows}
      />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.color.code}
      name={data.examples.color.name}
    >
      <Textarea
        bind:value={value5}
        id="textarea"
        name="textare"
        placeholder="start typing.."
        class={border}
      />
    </ComponentExampleTemplate>    
    <ComponentExampleTemplate
    name={data.examples.sizes.name}
    exampleOnly
  >
    <Label>sm</Label>
    <Textarea size="sm" placeholder={"size=\"sm\""} />
    <Label>md</Label> 
    <Textarea size="md" placeholder={"size=\"md\""}/>
    <Label>lg</Label>
    <Textarea size="lg" placeholder={"size=\"lg\""} />
  </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

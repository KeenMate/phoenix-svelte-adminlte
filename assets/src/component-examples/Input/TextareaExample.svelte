<script>
  import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";

  import { Textarea, TextInput , InputGroup} from "svelte-adminlte";
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
      { name: "disabeld", type: "bool", comment: "" },
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
        code: '<Textarea bind:value id="textarea" name="textare" rows={5} placeholder="start typing.."/>',
      },
      size: {
        name: "Cols and Rows",
        code: '<Textarea bind:value id="textarea" name="textare" rows={5} placeholder="start typing.."/>',
      },
      color: {
        name: "Border color based on value length",
        code: '<Textarea bind:value id="textarea" name="textare" rows={5} placeholder="start typing.."/>',
      },
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

  $:border = getclass(value5);

  let rows,cols;
  let value1, value2, value3, value4,value5;
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
      bind:value = {value2}

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
      bind:value = {value3}
        maxlength = {8}
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
      <TextInput bind:value={cols} placeholder="columns"/>
      <TextInput bind:value={rows} placeholder="rows"/>
    </InputGroup>

      <Textarea
      bind:value = {value4}

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
        bind:value = {value5}
        id="textarea"
        name="textare"
        placeholder="start typing.."
        class={border}
      />
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

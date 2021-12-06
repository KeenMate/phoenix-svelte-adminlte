<script>
    import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";
  
  import {Textarea} from "svelte-adminlte"
    let data = {
      name: "",
      text: "",
      props: [
        { name: "id", type: "string", comment: "" },
        { name: "value", type: "string", comment: "" },
        { name: "name", type: "string", comment: "" },
        { name: "rows", type: "number", comment: "" },
        { name: "placeholder", type: "string", comment: "" },
        { name: "pattern", type: "string", comment: "" },
        { name: "readonly", type: "bool", comment: "" },
        { name: "disabeld", type: "bool", comment: "" },
        ],
      examples: {
        minimal: {
          name: "minimal",
          code: "<Textarea bind:value\/>",
        },
        basic: {
          name: "basic",
          code: '<Textarea bind:value id=\"textarea\" name=\"textare\" rows={5} placeholder=\"start typing..\"\/>',
        }
        
      },
    };
  
    let value;
  </script>
  
  <ComponentPageTemplate
    text={data.text}
    properties={data.props}
  >
    <svelte:fragment slot="examples">
      <ComponentExampleTemplate
        code={data.examples.minimal.code}
        name={data.examples.minimal.name}
      >
        <Textarea bind:value/>
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
        code={data.examples.basic.code}
        name={data.examples.basic.name}
      >
        <Textarea bind:value id="textarea" name="textare" rows={5} placeholder="start typing.."/>
      </ComponentExampleTemplate>
    </svelte:fragment></ComponentPageTemplate
  >
  
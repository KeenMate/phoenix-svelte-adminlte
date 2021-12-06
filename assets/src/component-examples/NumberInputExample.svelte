<script>
    import ComponentPageTemplate from "../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../controls/Components/ComponentExampleTemplate.svelte";
  
    import {NumberInput} from "svelte-adminlte"
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
        ],
      examples: {
        minimal: {
          name: "minimal usage",
          code: '<NumberInput bind:value name=\"number-input\" id=\"number-input\" placeholder=\"Click to start typing...\"\/>',
        },
        basic: {
          name: "basic usage",
          code: '<NumberInput bind:value name=\"number-input\" id=\"number-input\" placeholder=\"Click to start typing...\"\/>',
        }
        
      },
    };
      let value = null;
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
        <NumberInput bind:value/>
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
        code={data.examples.basic.code}
        name={data.examples.basic.name}
      >
        <NumberInput bind:value name="number-input" 
        id="number-input" placeholder="Click to start typing..."/>
      </ComponentExampleTemplate>
    </svelte:fragment></ComponentPageTemplate
  >
  
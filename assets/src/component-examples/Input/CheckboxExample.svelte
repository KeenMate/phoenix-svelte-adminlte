<script>
    import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";
  
    import { Checkbox, Label } from "svelte-adminlte";
  
  
    let data = {
      name: "TextInput",
      text: "Component is used for bool input.You HAVE to add label into slot",
      props: [
        { name: "id", type: "string", comment: "" },
        { name: "value", type: "string", comment: "" },
        { name: "name", type: "string", comment: "" },
        { name: "checked", type: "bool", comment: "" },
        { name: "disabled", type: "bool", comment: "" },
        { name: "class", type: "bool", comment: "class on div above checkbox" },
        { name: "level", type: "string ", comment: "" }
        ],
        slots: [
          {name: "default", comment:"slot inside the div after input" }
        ],
      examples: {
        minimal: {
          name: "Minimal Checkbox usage",
          code: '<Checkbox bind:checked={a} id=\"valueInputa\" ><Label inputId=\"valueInputa\"> value <\/Label><\/Checkbox>',
        },
        basic: {
          name: "Checkbox basic usage",
          code: '<Checkbox bind:checked={b} name=\"value\" id=\"valueInputb\" ><Label inputId=\"valueInputb\"> value <\/Label><\/Checkbox>',
        },
        disabled:{
          name: "Disabled Checkbox",
          code: '<Checkbox bind:checked={c} name=\"value\" id=\"valueInputc\" disabled><Label inputId=\"valueInputc\"> value <\/Label><\/Checkbox>  '
        }
      },
    };
  
    let a = "",b="",c="";
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
      <Checkbox bind:checked={a} id="valueInputa" ><Label inputId="valueInputa"> value </Label></Checkbox>
        {a}
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
        code={data.examples.basic.code}
        name={data.examples.basic.name}
      >
      <Checkbox bind:checked={b} name="value" id="valueInputb" ><Label inputId="valueInputb"> value </Label></Checkbox>
      {b}
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
        code={data.examples.disabled.code}
        name={data.examples.disabled.name}>
        <Checkbox bind:checked={c} name="value" id="valueInputc" disabled><Label inputId="valueInputc"> value </Label></Checkbox>
      {c}
      </ComponentExampleTemplate>
    </svelte:fragment></ComponentPageTemplate
  >
  
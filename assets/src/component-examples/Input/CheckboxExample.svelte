<script>
    import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";
  
    import { Checkbox, Label,TableCondensed } from "svelte-adminlte";
  
  
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
        { name: "level", type: "string ", comment: "colors" }
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
        },
        colors:{
          name:'colors'
        }
      },
    };
  
    let a = "",b="",c="";
    let levels = ["red","green","blue","orange","yellow","pink","purple"]
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
      <ComponentExampleTemplate
        name={data.examples.colors.name}
        exampleOnly>
        
        <TableCondensed>
          <svelte:fragment slot="headers">
            <tr>
              <th>level</th>
              <th>radio</th>
            </tr>
          </svelte:fragment>
          {#each levels as l}
            <tr>
              <td>{l}</td>
              <td>
                <Checkbox level={l} id={l} checked >
                  <Label inputId={l} >{l}</Label>
                </Checkbox>
              </td>
            </tr>
          {/each}
        </TableCondensed>
      </ComponentExampleTemplate>
    </svelte:fragment></ComponentPageTemplate
  >
  
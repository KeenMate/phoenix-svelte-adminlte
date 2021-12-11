<script>
  import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";

  import { Radio, Label ,TableCondensed} from "svelte-adminlte";
  let data = {
    name: "RadioExample",
    text: "Input with type radio using icheck. You have **to have** label with set id inside slot.",
    props: [
      { name: "id", type: "string", comment: "" },
      { name: "value", type: "string", comment: "" },
      { name: "name", type: "string", comment: "" },
      { name: "disabled", type: "bool", comment: "" },
      { name: "group", type: "string", comment: "" },
      { name: "level", type: "string", comment: "color" },
    ],
    examples: {
      minimal: {
        name: "Usage",
        code: '{#if selected}\r\n      {selected} is selected\r\n      {/if}\r\n        <Radio bind:group={selected} value={1} name="chck" id="chck1">\r\n          <Label inputId="chck1">Checkbox1</Label>\r\n        </Radio>\r\n        <Radio bind:group={selected} value={2} name="chck" id="chck2">\r\n          <Label inputId="chck2">Checkbox2</Label>\r\n        </Radio>\r\n        <Radio bind:group={selected} value={3} name="chck" id="chck3">\r\n          <Label inputId="chck3">Checkbox3</Label>\r\n        </Radio>',
      },
      color:{
        name:"Colors"
      }
    },
  };
  let transportType = ["Bus", "Car", "Train", "Plane"];
  let levels = ["red","green","blue","orange","yellow","pink","purple"]
  let selected = null;
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
      {#if selected}
        {selected} is selected
      {/if}

      {#each transportType as type}
        <Radio bind:group={selected} value={type} name="chck" id={type}>
          <Label inputId={type}>{type}</Label>
        </Radio>
      {/each}
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      name={data.examples.color.name} >
      <TableCondensed>
        <svelte:fragment slot="headers">
          <tr>
            <th>color</th>
            <th>radio</th>
          </tr>
        </svelte:fragment>
        {#each levels as l}
          <tr>
            <td>{l}</td>
            <td>
              <Radio level={l} id={l} >
                <Label inputId={l} >{l}</Label>
              </Radio>
            </td>
          </tr>
        {/each}
      </TableCondensed>
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

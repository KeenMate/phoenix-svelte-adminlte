<script>
    import ComponentPageTemplate from "../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../controls/Components/ComponentExampleTemplate.svelte";
  
    import {Radio,Label} from "svelte-adminlte"
    let data = {
      name: "RadioExample",
      text: "Input with type radio using icheck. You have ** to have ** label with set id inside slot.",
      props: [
        { name: "id", type: "string", comment: "" },
        { name: "value", type: "string", comment: "" },
        { name: "name", type: "string", comment: "" },
        { name: "disabled", type: "bool", comment: "" },
        { name: "group", type: "string", comment: "" },
        { name: "level", type: "string", comment: "" },
        ],
      examples: {
        minimal: {
          name: "usage",
          code: '{#if selected}\r\n      {selected} is selected\r\n      {\/if}\r\n        <Radio bind:group={selected} value={1} name=\"chck\" id=\"chck1\">\r\n          <Label inputId=\"chck1\">Checkbox1<\/Label>\r\n        <\/Radio>\r\n        <Radio bind:group={selected} value={2} name=\"chck\" id=\"chck2\">\r\n          <Label inputId=\"chck2\">Checkbox2<\/Label>\r\n        <\/Radio>\r\n        <Radio bind:group={selected} value={3} name=\"chck\" id=\"chck3\">\r\n          <Label inputId=\"chck3\">Checkbox3<\/Label>\r\n        <\/Radio>',
        }
        
      },
    };
  
    let selected = null
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
        <Radio bind:group={selected} value={1} name="chck" id="chck1">
          <Label inputId="chck1">Checkbox1</Label>
        </Radio>
        <Radio bind:group={selected} value={2} name="chck" id="chck2">
          <Label inputId="chck2">Checkbox2</Label>
        </Radio>
        <Radio bind:group={selected} value={3} name="chck" id="chck3">
          <Label inputId="chck3">Checkbox3</Label>
        </Radio>
      </ComponentExampleTemplate>
      
    </svelte:fragment></ComponentPageTemplate
  >
  
<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import { EmailInput, FormGroup, Label } from "@keenmate/svelte-adminlte";

  let data = {
    name: "EmailInput",
    text: "Its Input with type emal.",
    props: [
      { name: "id", type: "string", comment: "" },
      { name: "value", type: "string", comment: "" },
      { name: "name", type: "string", comment: "" },
      { name: "placeholder", type: "string", comment: "" },
      { name: "pattern", type: "string", comment: "" },
      { name: "readonly", type: "bool", comment: "" },
      { name: "disabled", type: "bool", comment: "" },
      { name: "placeholder", type: "string", comment: "" },
      {
        name: "class",
        type: "HtmlElement",
        comment: "aditional classes on input element",
      },
    ],
    examples: {
      minimal: {
        name: "minimal usage",
        code: "<EmailInput bind:value={value}/>",
      },
      basic: {
        name: "basic usage",
        code: '<FormGroup>\r\n        <Label inputId="name">label:</Label>\r\n        <EmailInput bind:value={value} name="name" id="name" placeholder="type something.."/>\r\n</FormGroup>',
      },
      sizes:{
        name:"Sizes"
      }
    },
  };

  let value;
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
      <EmailInput bind:value />
      {value}
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.basic.code}
      name={data.examples.basic.name}
      ><FormGroup>
        <Label inputId="name">label:</Label>
        <EmailInput
          bind:value
          name="name"
          id="name"
          placeholder="type something.."
        />
      </FormGroup>
      {value}
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
    name={data.examples.sizes.name}
    exampleOnly
  >
    <Label>sm</Label>
    <EmailInput size="sm" placeholder={"size=\"sm\""} />
    <Label>md</Label> 
    <EmailInput size="md" placeholder={"size=\"md\""}/>
    <Label>lg</Label>
    <EmailInput size="lg" placeholder={"size=\"lg\""} />
  </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import {PhoneField} from "svelte-adminlte"

  let data = {
    text: "",
    props: [
      { name: "phone", type: "", comment: "Phone number" },
      ],
    events:[
      {name:"input",comment:"is fired every time user types or changes prefix", params:"detail = phone number"},
    ],
    examples: {
      minimal: {
        name: "Usage",
        code: '<PhoneField phone={phone} on:input={e => phone = e.detail}\/>',
      }
      
    },
  };

  let phone = 12345
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
      <PhoneField phone={phone} on:input={e => phone = e.detail}/>
        {phone}
    </ComponentExampleTemplate>
    
  </svelte:fragment></ComponentPageTemplate
>

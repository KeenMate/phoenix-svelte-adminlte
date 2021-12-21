<script>
  import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";

  import {PhoneField} from "svelte-adminlte"

  let data = {
    text: "",
    props: [
      { name: "phone", type: "", comment: "Phone number" },
      ],
    events:[
      {name:"input",comment:"", params:""},
    ],
    examples: {
      minimal: {
        name: "Usage  EVENTS DONT WORK",
        code: '',
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

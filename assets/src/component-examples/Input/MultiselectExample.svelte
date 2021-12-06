<script>
    import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";
  
    import {Multiselect} from "svelte-adminlte"

    let data = {
      name: "Multiselect",
      text: "Multiselect using [select2](https://select2.org/)",
      props: [
        { name: "value", type: "string", comment: "" },
        { name: "placeholder", type: "string", comment: "" },
        { name: "readonly", type: "bool", comment: "" },
        ],
      events:[
        {name:"search",comment:"", params:"search text"},
        {name:"change",comment:"", params:"selected values"}
      ],
      examples: {
        minimal: {
          name: "",
          code: '',
        }
        
      },
    };
  
    
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
        
      </ComponentExampleTemplate>
      
    </svelte:fragment></ComponentPageTemplate
  >
  
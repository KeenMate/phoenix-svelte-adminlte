<script>
    import ComponentPageTemplate from "../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../controls/Components/ComponentExampleTemplate.svelte";
  
  
    let data = {
      name: "",
      text: "",
      props: [
        { name: "", type: "", comment: "" },
        ],
      events:[
        {name:"",comment:"", params:""}
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
  
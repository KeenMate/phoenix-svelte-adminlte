<script>
      import ComponentPageTemplate from "../../../components/component-templates//ComponentPageTemplate.svelte";
      import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";
  
    let data = {
      text: "",
      props: [
        { name: "", type: "", comment: "" },
        ],
      events:[
        {name:"",comment:"", params:""},
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
  
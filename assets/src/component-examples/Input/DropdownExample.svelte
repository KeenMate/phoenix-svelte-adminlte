<script>
    import ComponentPageTemplate from "../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../controls/Components/ComponentExampleTemplate.svelte";
  
    
    let data = {
      name: "Dropdown",
      text: "NEPOUZIVA SE :)select2",
      props: [
        { name: "value", type: "string", comment: "" },
        { name: "placeholder", type: "string", comment: "" },
        { name: "readonly", type: "bool", comment: "" },
        { name: "invalid", type: "bool", comment: "" },
        ],
      events:[
        {name:"search", params:"query", comment:""},
        {name:"change", params:"selectedValue", comment:""}
      ],
      examples: {
        minimal: {
          name: "Minimal dropdown usage",
          code: '',
        }
        
      },
    };
  
    let value=""
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
        <Dropdown bind:value={value}>
            <option value="a">A</option>
            <option value="b">B</option>
            <option value="c">C</option>
        </Dropdown>
      </ComponentExampleTemplate>
      
    </svelte:fragment></ComponentPageTemplate
  >
  
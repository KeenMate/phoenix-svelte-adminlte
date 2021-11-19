<script>
  import ComponentPageTemplate from "./ComponentPageTemplate.svelte";
  import ComponentExample from "./ComponentExample.svelte";

  let testComponent = {
    name: "test-component name",
    text: "Lorem Ipsum atd",
    props: [{ name: "prop1", type: "type1", Comment: "comment1" }],
    examples:[{code: "<script>\\r\\n  import ComponentPageTemplate from \\\".\\/ComponentPageTemplate.svelte\\\";\\r\\n  import ComponentExample from \\\".\\/ComponentExample.svelte\\\"\\r\\n\\r\\n\\r\\n\\r\\n  let testComponent = {\\r\\n    name: \\\"test\\\",\\r\\n    text: \\\"Lorem Ipsum atd\\\",\\r\\n    props: [{ name: \\\"prop1\\\", type: \\\"type1\\\", Comment: \\\"comment1\\\" }],\\r\\n    code:\\\"\\\"\\r\\n  };\\r\\n<\\/script>\\r\\n\\r\\n<ComponentPageTemplate\\r\\n  name={testComponent.name}\\r\\n  text={testComponent.text}\\r\\n  properties={testComponent.props}\\r\\n><svelte:fragment slot=\\\"examples\\\">\\r\\n<div class=\\\"row\\\">\\r\\n    <ComponentExample code =\\\"\\\"> <\\/ComponentExample>\\r\\n<\\/div>\\r\\n\\r\\n<\\/svelte:fragment><\\/ComponentPageTemplate>",
    name: "example1" },{code: "<script>\\r\\n  import ComponentPageTemplate from \\\".\\/ComponentPageTemplate.svelte\\\";\\r\\n  import ComponentExample from \\\".\\/ComponentExample.svelte\\\"\\r\\n\\r\\n\\r\\n\\r\\n  let testComponent = {\\r\\n    name: \\\"test\\\",\\r\\n    text: \\\"Lorem Ipsum atd\\\",\\r\\n    props: [{ name: \\\"prop1\\\", type: \\\"type1\\\", Comment: \\\"comment1\\\" }],\\r\\n    code:\\\"\\\"\\r\\n  };\\r\\n<\\/script>\\r\\n\\r\\n<ComponentPageTemplate\\r\\n  name={testComponent.name}\\r\\n  text={testComponent.text}\\r\\n  properties={testComponent.props}\\r\\n><svelte:fragment slot=\\\"examples\\\">\\r\\n<div class=\\\"row\\\">\\r\\n    <ComponentExample code =\\\"\\\"> <\\/ComponentExample>\\r\\n<\\/div>\\r\\n\\r\\n<\\/svelte:fragment><\\/ComponentPageTemplate>",
    name: "example2" },
    
    ]
 
    };
</script>

<ComponentPageTemplate
  name={testComponent.name}
  text={testComponent.text}
  properties={testComponent.props}
  ><svelte:fragment slot="examples">
    <div class="row">
      <ComponentExample code={testComponent.examples[0].code} name={testComponent.examples[0].name}> <input type="submit"></ComponentExample>
      <ComponentExample code={testComponent.examples[0].code} name={testComponent.examples[0].name}> <input type="submit" disabled></ComponentExample>
        
    </div>
  </svelte:fragment></ComponentPageTemplate
>

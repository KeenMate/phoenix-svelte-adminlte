<script>
    import ComponentPageTemplate from "../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../controls/Components/ComponentExampleTemplate.svelte";
  
    import { TextInput } from "svelte-adminlte";
  
  
    let data = {
      name: "TextInput",
      text: "Component is used for user input. It can be used for multiple types of input",
      props: [
        { name: "id", type: "string", comment: "" },
        { name: "value", type: "string", comment: "" },
        { name: "name", type: "string", comment: "" },
        { name: "placeholder", type: "string", comment: "" },
        { name: "pattern", type: "regex", comment: "" },
        { name: "readonly", type: "bool ", comment: "false is default" },
        { name: "disabled", type: "bool", comment: "false is default" },
        { name: "inputMask", type: "string", comment: "" },
        { name: "invalid", type: "bool", comment: "false is default" },
        { name: "inputElement", type: "", comment: "you can direcly acces input through this" },
        
    
    
    ],
      examples: {
        minimal: {
          name: "minimal TextInput usage",
          code: '<TextInput bind:value={value}\/>',
        },
        basic: {
          name: "TextInput basic usage",
          code: '<TextInput bind:value={value} id=\"inputId\" name=\"inputName\" placeholder=\"Type something...\"\/>',
        },
        pattern:{
          name: "TextInput with pattern",
          code: '<form action=\"\/foo\">\r\n        <TextInput bind:value={c} id=\"inputId\" name=\"inputName\" placeholder=\"Type 3 letter countrycode...\" pattern=\"[A-Za-z]{3}\"\/>\r\n        <input type=\"submit\" \/>\r\n<\/form >'
        }
      },
    };
  
    let a = "",b="",c="";
  </script>
  
  <ComponentPageTemplate
    text={data.text}
    properties={data.props}
  >
    <svelte:fragment slot="examples">
      <ComponentExampleTemplate
        code={data.examples.minimal.code}
        name={data.examples.minimal.name}
      >
        <TextInput bind:value={a}/>
        {a}
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
        code={data.examples.basic.code}
        name={data.examples.basic.name}
      >
        <TextInput bind:value={b} id="inputId" name="inputName" placeholder="Type something..."/>
        {b}
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
        code={data.examples.pattern.code}
        name={data.examples.pattern.name}>
        <form action="/foo">
        <TextInput bind:value={c} id="inputId" name="inputName" placeholder="Type 3 letter countrycode..." pattern="[A-Za-z]{3}"/>
            <input type="submit" />
    </form >
      </ComponentExampleTemplate>
    </svelte:fragment></ComponentPageTemplate
  >
  
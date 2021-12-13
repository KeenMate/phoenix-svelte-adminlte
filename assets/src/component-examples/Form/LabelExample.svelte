<script>
    import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";
  
    import {Label,TextInput,FormGroup} from "svelte-adminlte"
    let data = {
      name: "",
      text: "",
      props: [
        { name: "inputId", type: "string", comment: "Id of the input. Equivalent to for html atribute" },
        ],
      examples: {
        minimal: {
          name: "Usage",
          code: '<FormGroup>\r\n     <Label>TextInput: <TextInput \/><\/Label>\r\n<\/FormGroup>',
        },
        inputID: {
          name: "Using inputId",
          code: '<FormGroup>\r\n  <Label inputID=\"textinput\">TextInput: <\/Label>\r\n<TextInput id=\"textinput\"\/>\r\n<\/FormGroup>',
        }
        
      },
    };
  
    
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
      <FormGroup>
        <Label>TextInput: <TextInput /></Label>
      </FormGroup>
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
      code={data.examples.inputID.code}
      name={data.examples.inputID.name}
    >
<FormGroup>
  <Label inputID="textinput">TextInput: </Label><TextInput id="textinput"/>
</FormGroup>
    </ComponentExampleTemplate>
      
    </svelte:fragment></ComponentPageTemplate
  >
  
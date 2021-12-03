<script>
    import ComponentPageTemplate from "../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../controls/Components/ComponentExampleTemplate.svelte";
  
    import {FileInput} from "svelte-adminlte"

    let data = {
      name: "FileInput",
      text: "Input elment with type upload. value and placeholder doesnt forks. Its better to use uppy(Uload Modal).",
      props: [
        { name: "id", type: "string", comment: "" },
        { name: "value", type: "string", comment: "doesnt work, dont use" },
        { name: "name", type: "string", comment: "" },
        { name: "multiple", type: "bool", comment: "default is false which means singlefile" },
        { name: "placeholder", type: "string", comment: "doesnt work, dont use" },
        { name: "pattern", type: "string", comment: "" },
        { name: "readonly", type: "bool", comment: "" },
        { name: "class", type: "string", comment: "class on input element" },
        ],
      events:[
        {name:"input",comment:"", params:"event.detail = uploaded files"}
      ],
      examples: {
        minimal: {
          name: "Minimal single file upload",
          code: '<FileInput on:input={(e)=>{file=e.detail}} id=\"fileupload\" name=\"fileupload\" value={file.name || null} placeholder=\"upload file...\" multiple\/>',
        },
        basic: {
          name: "Basic single file upload",
          code: '<FileInput on:input={(e)=>{file=e.detail}} id=\"fileupload\" name=\"fileupload\" value={file.name || null} placeholder=\"upload file...\" \/>',
        },
        multiple: {
          name: "Multiple file upload",
          code: '<FileInput on:input={(e)=>{file=e.detail}} id=\"fileupload\" name=\"fileupload\" value={file.name || null} placeholder=\"upload file...\" multiple\/>',
        }
      },
    };
  
    let file = {};
    $:console.log(file)
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
        <FileInput on:input={(e)=>{file=e.detail}}/>
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
        code={data.examples.basic.code}
        name={data.examples.basic.name}
      >
        <FileInput on:input={(e)=>{file=e.detail}} id="fileupload" name="fileupload" value={file.name || null}
            placeholder="upload file..." />
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
        code={data.examples.multiple.code}
        name={data.examples.multiple.name}
      >
        <FileInput on:input={(e)=>{file=e.detail}} id="fileupload" name="fileupload" value={file.name || null}
            placeholder="upload file..." multiple/>
      </ComponentExampleTemplate>
    </svelte:fragment></ComponentPageTemplate
  >
  
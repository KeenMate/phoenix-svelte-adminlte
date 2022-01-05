<script>
    import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";
    import notification from "../../../providers/notificationProvider";
    import { CkEditor } from "svelte-adminlte";
  
  
    let data = {
      name: "CkEditor",
      text: "CkEditor from [ckeditor.com](https://ckeditor.com/) wraped inside svelte component for easier use.If you want to bind it contents of editor, cant just bind value to your variable and insted you have to use input event with combination to value. It uses html with style to format. **You can only use one editor at the time, or it doesnt work**",
      props: [
        { name: "id", type: "string", comment: "You have to set this if you want to use more than one ckeditor per page" },
        { name: "value", type: "string", comment: "Content of editor only one way data flow(to component)." },
        { name: "disabled", type: "bool", comment: "If true,  component is disabled." },
        { name: "readonly", type: "bool", comment: "If true, component is readonly." },
        { name: "toolbar", type: "object", comment: "If true, component is readonly." },
        ],
      events:[
        {name:"input",comment:"tiggers every time user types after he changes focus or after some period of not typing", params:"detail.value = contents of editor"}
      ],
      examples: {
        basic: {
          name: "CkEditor usage",
          code: '<CkEditor bind:value={startingValue} id=\"editor1\" toolbar={{items: [ \'bold\', \'italic\', \'|\', \'undo\', \'redo\', \'|\', \'numberedList\', \'bulletedList\' ]}}\n          on:input={(e) => {notification.success(e.detail.replace(/\&/g, \"\&amp;\").replace(/</g, \"\&lt;\").replace(/>/g, \"\&gt;\").replace(/\"/g, \"\&quot;\").replace(/\'/g, \"\&#039;\"),\"CkEditor event e.datail\")}}>\n        </CkEditor>',
        }
      
        
      },
    };
  
    let startingValue = "<i>HELLO</i>"; 
    let startingValue2= "WORLD"
  </script>
  
  <ComponentPageTemplate
    text={data.text}
    properties={data.props}
    events={data.events}
  >
    <svelte:fragment slot="examples">
      <ComponentExampleTemplate
        code={data.examples.basic.code}
        name={data.examples.basic.name}
      >
        <CkEditor bind:value={startingValue} id="editor1" toolbar={{items: [ 'bold', 'italic', '|', 'undo', 'redo', '|', 'numberedList', 'bulletedList' ]}}
          on:input={(e) => {notification.success(e.detail.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#039;"),"CkEditor event e.datail")}}>
        </CkEditor>
      </ComponentExampleTemplate>
      
    </svelte:fragment></ComponentPageTemplate
  >
  
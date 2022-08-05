<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import {LteButton} from "@keenmate/svelte-adminlte"
  // import {UploadModal,LteButton} from "@keenmate/svelte-adminlte"
  let data = {
    name: "",
    text: "Using [Uppy](https://uppy.io/). Examples can be found at [https://uppy.io/examples/dashboard/](https://uppy.io/examples/dashboard/)",
    props: [
      { name: "maxFileSize", type: "number", comment: "Default is 1 000 000 000 (1GB)" },
      { name: "allowedFileTypes", type: "array", comment: "null | array of wildcards image/*, exact mime types image/jpeg, or file extensions .jpg: ['image/*', '.jpg', '.jpeg'," },
      { name: "maxNumberOfFiles", type: "number", comment: " null | number — total number of files that can be selected" },
      { name: "simultaneousUploads", type: "number", comment: "" },
      { name: "fieldName", type: "file", comment: "" },
      { name: "endpoint", type: "file", comment: "The destination URL for your uploads.You **HAVE** to set this or it will throw error." },
      ],
    events:[
      {name:"",comment:"", params:""},
    ],
    examples: {
      minimal: {
        name: "Minimal",
        code: '<script>\r\n  let upload\r\n<\/script>\r\n\r\n<LteButton on:click ={upload.openModal}>Upload files<\/LteButton>\r\n<UploadModal bind:this = {upload} endpoint=\"www.example.test\"><\/UploadModal>',
      }
      
    },
  };

  let upload;
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
      <b>This example always shows upload failed, because it isnt using real Endpoint</b>
      <LteButton on:click ={upload.openModal}>Upload files</LteButton> 
      <!-- <UploadModal bind:this = {upload} endpoint="www.example.test"></UploadModal> -->
    </ComponentExampleTemplate>
    
  </svelte:fragment></ComponentPageTemplate
>

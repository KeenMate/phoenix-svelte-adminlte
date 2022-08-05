<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import { FileInput, TableCondensed,Label } from "@keenmate/svelte-adminlte";

  let data = {
    name: "FileInput",
    text: "Input elment with type upload. value and placeholder doesnt forks. Its better to use uppy(Upload Modal).",
    props: [
      { name: "id", type: "string", comment: "" },
      { name: "value", type: "string", comment: "doesnt work, dont use" },
      { name: "name", type: "string", comment: "" },
      {
        name: "multiple",
        type: "bool",
        comment: "default is false which means singlefile",
      },
      { name: "placeholder", type: "string", comment: "doesnt work, dont use" },
      { name: "pattern", type: "string", comment: "" },
      { name: "readonly", type: "bool", comment: "" },
      { name: "class", type: "string", comment: "class on input element" },
    ],
    slots: [{ name: "[default]", comment: "text inside the input" }],
    events: [
      { name: "input", comment: "", params: "event.detail = uploaded files" },
    ],
    examples: {
      minimal: {
        name: "Minimal single file upload",
        code: "<FileInput\r\n  on:input={(e) => {\r\n    file = e.detail;\r\n  }}\r\n/>",
      },
      basic: {
        name: "Basic single file upload",
        code: '<FileInput\r\n  on:input={(e) => {file = e.detail;}}\r\n  id="fileupload" name="fileupload"\r\n  >{file && file.name ? file.name : "click to upload file..."}</FileInput>\r\n{file && file.name ? "total size: " + displaySize(file.size) + "kb" : ""}',
      },
      multiple: {
        name: "Multiple file upload",
        code: '<FileInput\r\n  on:input={(e) => {\r\n    files = e.detail;\r\n  }}\r\n  id="fileupload"\r\n  name="fileupload"\r\n  multiple\r\n  >{files && files.length\r\n    ? files.length + " files selected"\r\n    : "click to upload files..."}</FileInput\r\n>\r\n{#if files && files.length > 0}\r\n  <TableCondensed>\r\n    <svelte:fragment slot="headers"\r\n      ><tr>\r\n        <th>Name</th>\r\n        <th>Size</th>\r\n      </tr></svelte:fragment>\r\n      {#each files as f}\r\n          <tr>\r\n            <td>{f.name}</td>\r\n            <td>{displaySize(f.size)}kb</td>\r\n          </tr>\r\n      {/each}\r\n  </TableCondensed>\r\n{/if}',
      },
      sizes:{
        name: "Sizes"
      }
    },
  };

  function displaySize(size) {
    return Math.round((size / 1024) * 100) / 100;
  }

  let file = null;
  let files = null;
  $: console.log(file);
</script>

<ComponentPageTemplate
  text={data.text}
  properties={data.props}
  events={data.events}
  slots={data.slots}
>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.minimal.code}
      name={data.examples.minimal.name}
    >
      <FileInput
        on:input={(e) => {
          file = e.detail;
        }}
      />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.basic.code}
      name={data.examples.basic.name}
    >
      <FileInput
        on:input={(e) => {
          file = e.detail;
        }}
        id="fileupload"
        name="fileupload"
        >{file && file.name ? file.name : "click to upload file..."}</FileInput
      >
      {file && file.name ? "total size: " + displaySize(file.size) + "kb" : ""}
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.multiple.code}
      name={data.examples.multiple.name}
    >
      <FileInput
        on:input={(e) => {
          files = e.detail;
        }}
        id="fileupload"
        name="fileupload"
        multiple
        >{files && files.length
          ? files.length + " files selected"
          : "click to upload files..."}</FileInput
      >
      {#if files && files.length > 0}
        <TableCondensed>
          <svelte:fragment slot="headers"
            ><tr>
              <th>Name</th>
              <th>Size</th>
            </tr></svelte:fragment
          >
          {#each files as f}
            <tr>
              <td>{f.name}</td>
              <td>{displaySize(f.size)}kb</td>
            </tr>
          {/each}
        </TableCondensed>
      {/if}
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

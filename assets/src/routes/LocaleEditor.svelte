<script>
  import { onMount } from "svelte";
  import { LteButton, Card, PageHeader, Form } from "svelte-adminlte";
  import { _, locale } from "svelte-i18n";
  import "jsoneditor/dist/jsoneditor.min.css";
  import JSONEditor from "jsoneditor";

  import { saveLanguageFile,deleteSaveLocals , locales} from "../locale/i18n";

  let editorContainer;
  let json;
  let selectedLanguage = "cs";
  let editor;
  onMount(() => {
    editor = new JSONEditor(editorContainer, { mode: "code" });

    // set json
    /*const initialJson = {
      Array: [1, 2, 3],
      Boolean: true,
      Null: null,
      Number: 123,
      Object: { a: "b", c: "d" },
      String: "Hello World",
      t:{
        Array: [1, 2, 3],
      Boolean: true,
      Null: null,
      Number: 123,
      Object: { a: "b", c: "d" },
      String: "Hello World",
      t:{
        Array: [1, 2, 3],
      Boolean: true,
      Null: null,
      Number: 123,
      Object: { a: "b", c: "d" },
      String: "Hello World",
      t:{
        Array: [1, 2, 3],
      Boolean: true,
      Null: null,
      Number: 123,
      Object: { a: "b", c: "d" },
      String: "Hello World",
      t:{
        Array: [1, 2, 3],
      Boolean: true,
      Null: null,
      Number: 123,
      Object: { a: "b", c: "d" },
      String: "Hello World",
      }
      }
      }

      }
    };*/
    json = locales[$locale];
    console.log(locales)
    console.log(json);
    editor.set(json);
  });

  function saveJson() {
    json = editor.get();
    saveLanguageFile(json, selectedLanguage);
  }
</script>

<PageHeader> {$_("locale-editor.title")}<small>For all the polyglots</small></PageHeader>
<div class="row">
  <div class="col-9">
    <div class="edit-container" bind:this={editorContainer} />
  </div>
  <div class="col-3">
    <Card outline color="danger">
      <svelte:fragment slot="header">Actions</svelte:fragment>
      <Form>
        <LteButton on:click={saveJson}>SAVE</LteButton>
        <LteButton on:click={deleteSaveLocals}>DELETE</LteButton>
      
      </Form>
    </Card>
  </div>
</div>
 <style lang="scss">
   .edit-container {
     height: 75vh;
   }  
 </style>
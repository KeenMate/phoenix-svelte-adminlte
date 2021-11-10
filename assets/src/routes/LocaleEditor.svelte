<script>
  import { onMount } from "svelte";
  import { LteButton} from "svelte-adminlte"
  import { _ } from "svelte-i18n";
  import "jsoneditor/dist/jsoneditor.min.css";
  import JSONEditor from "jsoneditor";
  import { PageHeader } from "svelte-adminlte";

  import {en,cs,saveLanguageFile} from "../locale/i18n"

  let editorContainer;
  let json;
  let selectedLanguage = "cs"
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
    json = cs;
    console.log(json)
    editor.set(json);
  });


  function saveJson(){
    json = editor.get();
    saveLanguageFile(json,selectedLanguage);
  }
</script>

<PageHeader>Locale editor <small>For all the polyglots</small></PageHeader>
<LteButton on:click={saveJson}>SAVE</LteButton>   {$_("locale-editor.test")}
<div class="col-12">
  <div bind:this={editorContainer} />
</div>

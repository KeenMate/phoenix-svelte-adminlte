<script>
  import { onMount } from "svelte";

  import "jsoneditor/dist/jsoneditor.min.css";
  import JSONEditor from "jsoneditor";

  import { PageHeader } from "svelte-adminlte";

  let editorContainer;

  onMount(() => {
    const editor = new JSONEditor(editorContainer, { mode: "code" });

    // set json
    const initialJson = {
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
    };

    editor.set(initialJson);
  });
</script>

<PageHeader>Locale editor <small>For all the polyglots</small></PageHeader>

<div class="col-12">
  <div bind:this={editorContainer} />
</div>

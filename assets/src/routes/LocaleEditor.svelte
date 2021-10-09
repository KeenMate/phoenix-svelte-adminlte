<script>
  let editorContainer;

  $: {
    if (editorContainer) {
    }
  }
</script>

<div bind:this={editorContainer} class="editor-container" />

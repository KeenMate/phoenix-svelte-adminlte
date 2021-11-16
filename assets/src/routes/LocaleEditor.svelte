<script>
  import { onMount } from "svelte";
  import { LteButton, Card, PageHeader, Form ,FlexContainer,InputGroup,Label} from "svelte-adminlte";
  import { _, locale } from "svelte-i18n";
  import "jsoneditor/dist/jsoneditor.min.css";
  import JSONEditor from "jsoneditor";

  import { saveLanguageFile, deleteSaveLocals, locales ,languages,GetFlagPath} from "../locale/i18n";
import { optional } from "zod";


  let editorContainer;
  let json;
  let selectedLanguage = "cs";
  let editor;

$:ChangeJson(selectedLanguage);

  onMount(() => {
    editor = new JSONEditor(editorContainer, { mode: "code" });
    json = locales[selectedLanguage];
    editor.set(json);
  });

  function saveJson() {
    try {
      var valid_json = editor.get();
    } catch (err) {
      console.error("JSON is invalid");
    }
    if (json != undefined) {
      saveLanguageFile(valid_json, selectedLanguage);
    }
  }

  function ChangeJson(selectedLanguage){
    if(editor){
    json = locales[selectedLanguage];
    editor.set(json);}
  }
</script>

<PageHeader>
  {$_("locale-editor.title")}<small>For all the polyglots</small></PageHeader
>
<div class="row">
  <div class="col-9">
    <div class="edit-container" bind:this={editorContainer} />
  </div>
  <div class="col-3">
    <Card outline color="danger">
      <svelte:fragment slot="header">Actions</svelte:fragment>
      <Form>
        <FlexContainer>
          
          <LteButton on:click={saveJson}>SAVE</LteButton>
        <LteButton on:click={deleteSaveLocals}>DELETE</LteButton>
      
      <InputGroup>
        <Label forid="language-selector">Vyberte jazyk</Label>
        <select id="language-selector" bind:value={selectedLanguage}>
          {#each languages as l}
          <option value={l.code}><img src={GetFlagPath(l.code)} alt={l.img} />{l.title}</option>
          {/each}
          
        </select>
      </InputGroup>
    </FlexContainer>
      </Form>
    </Card>
  </div>
</div>

<style lang="scss">
  .edit-container {
    height: 75vh;
  }
</style>

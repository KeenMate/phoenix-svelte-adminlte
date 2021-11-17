<script>
  import { onMount } from "svelte";
  import {
    LteButton,
    Card,
    PageHeader,
    Form,
    FlexContainer,
    InputGroup,
    Label,
    Tabs,
    TabItem
  } from "svelte-adminlte";
  import { _, locale } from "svelte-i18n";
  import "jsoneditor/dist/jsoneditor.min.css";
  import JSONEditor from "jsoneditor";
  import LocalesList from "../controls/localEditor/LocalesList.svelte";

  import {
    saveLanguageFile,
    deleteSaveLocals,
    locales,
    languages,
    GetFlagPath,
  } from "../locale/i18n";
  import { optional } from "zod";

  let editorContainer;
  let json;
  let selectedLanguage = null;
  let editor;

  $: ChangeJson(selectedLanguage);

  $: console.log(editorContainer);
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

  function ChangeJson(selectedLanguage) {
    if (selectedLanguage) {
      if (!editor) {
        editor = new JSONEditor(editorContainer, { mode: "code" });
      }
      json = locales[selectedLanguage];
      editor.set(json);
    }
  }
</script>

<PageHeader>
  {$_("locale-editor.title")} <small>For all the polyglots</small></PageHeader
>
<div class="row">
  <div class:col-12={!selectedLanguage} class:col-3={selectedLanguage}>
    <LocalesList
      expanded={!selectedLanguage}
      on:edit={({ detail: lang }) => {
        console.log(lang);
        selectedLanguage = lang;
      }}
    />
  </div>
    <div class:col-9={selectedLanguage !== null} class:closed={selectedLanguage === null} >
      <Card outline color="primary" headerClass="p-0 pt-1 border-bottom-0" noPadding={true} tabs> 
        <svelte:fragment slot="fullHeader">
          <Tabs>
            <li class="pt-2 px-3">
              <h3 class="card-title">{selectedLanguage}</h3>
            </li>
            <!-- <TabItem active={true} >{$_("locale-editor.edit")}</TabItem> -->
            <div class="card-tools pull-right ml-auto">
              <LteButton color="primary" small on:click={saveJson}>
                <i class="fas fa-save" />
              </LteButton>

              <LteButton
                color="danger"
                small
                on:click={() => (selectedLanguage = null)}
              >
                <i class="fas fa-times" />
              </LteButton>
            </div>
          </Tabs>
        </svelte:fragment>
        <div class="edit-container" bind:this={editorContainer} />
      </Card>
    </div>
</div>

<!-- <div class="row">
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
</div> -->
<style lang="scss">
  .edit-container {
    height: 75vh;
  }
  .closed {
    width: 0px;
  }
</style>

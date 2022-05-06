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
		BreadcrumbItem,
	} from "svelte-adminlte";
	import { _ } from "svelte-i18n";
	import "jsoneditor/dist/jsoneditor.min.css";

	var JSONEditor;
	import("jsoneditor").then((module) => {
		JSONEditor = module.default;
	});

	import LocalesList from "../components/localEditor/LocalesList.svelte";
	import notification from "../providers/notificationProvider";

	import { saveLanguageFile, deleteSaveLocals, locales } from "../locale/i18n";
	import { optional } from "zod";

	let editorContainer;
	let json;
	let selectedLanguage = null;
	let editor;

	$: ChangeJson(selectedLanguage);

	function saveJson() {
		try {
			var valid_json = editor.get();
		} catch (err) {
			console.error("JSON is invalid");
		}
		if (json != undefined) {
			saveLanguageFile(valid_json, selectedLanguage);
			notification.success(
				$_("notifications.localeEditor.saved.message", {
					values: { locale: selectedLanguage },
				}),
				$_("notifications.localeEditor.saved.title")
			);
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
	<svelte:fragment>
		{$_("localeEditor.title")} <small>For all the polyglots</small>
	</svelte:fragment>

	<svelte:fragment slot="breadcrumbs">
		<BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
		<BreadcrumbItem active>{$_("localeEditor.title")}</BreadcrumbItem>
	</svelte:fragment>
</PageHeader>
<div class="row">
	<div class={selectedLanguage ? "col-lg-3 col-md-12" : "col-12"}>
		<LocalesList
			expanded={!selectedLanguage}
			on:edit={({ detail: lang }) => {
				selectedLanguage = lang;
			}}
		/>
	</div>

	<div class={selectedLanguage ? "col-lg-9 col-md-12" : "closed"}>
		<Card
			outline
			color="primary"
			headerClass="p-0 pt-1 border-bottom-0"
			noPadding={true}
			tabs
		>
			<svelte:fragment slot="header">
				<h5 class="cardTitle">{selectedLanguage}</h5>
			</svelte:fragment>
			<svelte:fragment slot="tools">
				<!-- <TabItem active={true} >{$_("localeEditor.edit")}</TabItem> -->
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
				<LteButton color="danger" small on:click={deleteSaveLocals}>
					<i class="fas fa-trash" />
				</LteButton>
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
		overflow: hidden;
	}
</style>

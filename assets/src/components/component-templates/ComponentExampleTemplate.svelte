<script>
	import { HighlightSvelte } from "svelte-highlight";

	import { Card, LteButton } from "svelte-adminlte";
	import notification from "../../providers/notificationProvider";

	import { _ } from "svelte-i18n";

	export let name = "";
	export let code = "";
	export let codeonly = false;
	export let exampleOnly = false;

	export function copyToClipboard() {
		navigator.clipboard.writeText(code);
		notification.success(
			$_("notifications.componentExampleTemplate.copied.message")
		);
	}
</script>

<Card class="card-width " color="info" outline>
	<svelte:fragment slot="header">{name}</svelte:fragment>
	<svelte:fragment slot="tools"
		>{#if code != "" && code != null && code != undefined}
			<LteButton color="success" on:click={copyToClipboard} small
				><i class="fas fa-copy" /></LteButton
			>
		{/if}</svelte:fragment
	>
	<div class="row">
		<div
			class:col-md-6={!exampleOnly}
			class:col-md-12={exampleOnly}
			class:d-none={codeonly}
			class="col-12"
		>
			<slot />
		</div>
		{#if !exampleOnly}
			<div
				class:line-left={!codeonly}
				class:col-md-6={!codeonly}
				class:col-md-12={codeonly}
				class="col-12"
			>
				<div class=" highlighter">
					<HighlightSvelte {code} />
				</div>
			</div>
		{/if}
	</div>
</Card>

<style lang="sass">
.line-left
  border-left: darkgrey solid 2px
.row
  min-height: 150px
:global
  .card-width
    width: 100%
    margin: 10 20px
    .card-body
      padding: 0.75em
  .highlighter
    background-color: #f5f5f5
    height: 100%
    box-shadow: 0 0 1px rgb(0 0 0 / 13%), 0 1px 3px rgb(0 0 0 / 20%)
    pre
      margin:0 !important
      padding: 0 0 0 4px !important
      background-color: #f5f5f5
    code
      margin: 0 !important
      padding: 0 !important
      font-size: 0.8em
      white-space: break-spaces
      background-color: #f5f5f5


</style>

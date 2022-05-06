<script>
	import { Card } from "svelte-adminlte";
	import { _ } from "svelte-i18n";
	import SvelteMarkdown from "svelte-markdown";
	// name value comment
	export let properties = null;
	//name params comment
	export let events = null;
	//name properties comments
	export let slots = null;
	//export let name;
	export let text;
</script>

<div class="row ">
	<div class="col-lg-8 col-md-12  scroll order-lg-0 order-1">
		<div class="row margin">
			<slot name="examples" />
		</div>
	</div>
	<div class="col-lg-4 col-md-12 order-lg-1 order-0">
		{#if text}
			<Card color="danger" outline>
				<svelte:fragment slot="header">
					{$_("componentPageTemplate.textTitle")}
				</svelte:fragment>
				<SvelteMarkdown source={text} />
			</Card>
		{/if}
		{#if properties}
			<Card color="danger" outline>
				<svelte:fragment slot="header">
					{$_("componentPageTemplate.propsTitle")}
				</svelte:fragment>
				{#each properties as prop}
					<p>
						<b>{prop.name}</b>
						{#if prop.type}
							[{prop.type}]
						{/if}
						<br /><i><SvelteMarkdown source={prop.comment} /></i>
					</p>
				{/each}
			</Card>
		{/if}
		{#if events}
			<Card color="danger" outline>
				<svelte:fragment slot="header">
					{$_("componentPageTemplate.eventsTitle")}
				</svelte:fragment>
				{#each events as event}
					<p>
						<b>{event.name}</b>
						{#if event.params}
							[{event.params}]
						{/if}
						<br /><i><SvelteMarkdown source={event.comment} /></i>
					</p>
				{/each}
			</Card>
		{/if}
		{#if slots}
			<Card color="danger" outline>
				<svelte:fragment slot="header">
					{$_("componentPageTemplate.slotsTitle")}
				</svelte:fragment>
				{#each slots as slot}
					<p>
						<b>{slot.name}</b>
						{#if slot.params}
							({slot.params})
						{/if}
						<br /><i><SvelteMarkdown source={slot.comment} /></i>
					</p>
				{/each}
			</Card>
		{/if}
	</div>
</div>

<style lang="sass">
  .scroll
    overflow-x: hidden
    overflow-y: visible
    //height: 85vh
  .margin
    margin-left: 1px
  // ::-webkit-scrollbar
  //   width: 5px
  // ::-webkit-scrollbar-track
  //   background: #f1f1f1
  // ::-webkit-scrollbar-thumb
  //   background: #888
  // ::-webkit-scrollbar-thumb:hover
  //   background: #555
</style>

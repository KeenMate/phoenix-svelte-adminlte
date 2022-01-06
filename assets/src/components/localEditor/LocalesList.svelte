<script>
  import {createEventDispatcher} from "svelte"
  import {_} from "svelte-i18n"
  import {getFlagPath, languages} from "../../locale/i18n"
  import {Card, TableCondensed} from "svelte-adminlte"
  const dispatch = createEventDispatcher()
  export let expanded = false
  console.log(languages)
</script>

<Card outline color="primary" noPadding>
	<svelte:fragment slot="header">{$_("locales-list.card-title")}</svelte:fragment>

	<div class="row">
		<div class="col-12">
			<TableCondensed class="locales-list {expanded ? 'expanded' : ''}">
				<tr slot="headers">
					<!-- <th class="actions">Actions</th> -->
					<th>{$_("locales-list.language")}</th>
					{#if expanded}
						<th>{$_("locales-list.flag")}</th>
						<th>{$_("locales-list.code")}</th>
					{/if}
				</tr>
				{#each languages as locale}
					<tr>
						<!-- <td class="actions">
							<LteButton color="danger" xsmall on:click={() => onDelete(user)}>
								<i class="fas fa-trash fa-fw" />
							</LteButton>
						</td> -->
						<td class="title">
							<a href="#" on:click|preventDefault={() => dispatch("edit", locale.code)}>
								{locale.title}
							</a>
						</td>
						{#if expanded}
							<td><img src={getFlagPath(locale.code)} alt={locale.img + " flag"} /> ({locale.img})</td>
							<td>{locale.code}</td>
						{/if}
					</tr>
				{/each}
			</TableCondensed>
		</div>
	</div>
</Card>

<style lang="scss">
	th {
		border-top: none;
	}
	:global {
		.locales-list {
			display: grid;
			grid-template-columns: auto repeat(2, 1fr);
			&:not(.expanded) {
				grid-template-columns:  1fr;
			}
			thead,
			tbody,
			* > tr {
				display: contents;
			}
		}
	}
</style>
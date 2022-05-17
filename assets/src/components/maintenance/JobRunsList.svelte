<script>
	import { createEventDispatcher } from "svelte";
	import { _ } from "svelte-i18n";
	import { Card, TableCondensed, LteButton, AutoScroll } from "svelte-adminlte";
	import JobsProvider from "../../providers/jobsProvider";
	import github from "svelte-highlight/src/styles/github";

	const dispatch = createEventDispatcher();
	let jobRuns = [];
	let loading = false;
	function loadJobs() {
		loading = true;
		JobsProvider.getJobRuns()
			.then((res) => {
				console.log(res.data);
				if (res.data) jobRuns = res.data;
			})
			.catch((er) => console.log(er))
			.finally(() => (loading = false));
	}
	loadJobs();

	let addModal;
</script>

<Card outline color="primary" noPadding>
	<svelte:fragment slot="header">{$_("localesList.cardTitle")}</svelte:fragment>
	<div slot="tools">
		<LteButton color="info" xsmall on:click={() => loadJobs()}>
			<i class="fas fa-sync fa-fw" />
		</LteButton>
		<LteButton color="success" xsmall on:click={() => addModal.openModal()}>
			{$_("jobsList.newJob")}
		</LteButton>
	</div>

	<div class="row">
		<div class="col-12">
			<AutoScroll>
				<TableCondensed>
					<tr slot="headers">
						<th class="actions">{$_("common.labels.actions")}</th>
						<th>{$_("common.labels.Id")}</th>
						<th>{$_("common.labels.name")}</th>
						<th>{$_("jobsList.cron")}</th>
						<th>{$_("jobsList.showScript")}</th>
					</tr>
					{#if jobRuns?.length == 0}
						<tr>
							<td colspan="100">
								{$_("common.labels.empty")}
							</td>
						</tr>
					{/if}
					{#each jobRuns as jobRun}
						<tr>
							<td>
								{jobRun.endTime}
							</td>
							<td class="title">
								{jobRun.jobName}
							</td>
							<td>
								{jobRun.scriptName}
							</td>
							<td>
								{jobRun.status}
							</td>

							<td>
								{jobRun.duration / 1000}ms
							</td>
							<td class="actions">
								<LteButton
									color="info"
									xsmall
									on:click={() => console.log(jobRun)}
									disabled={loading}
								>
									<i class="fas fa-eye fa-fw" />
								</LteButton>
							</td></tr
						>
					{/each}
				</TableCondensed>
			</AutoScroll>
		</div>
	</div>
</Card>

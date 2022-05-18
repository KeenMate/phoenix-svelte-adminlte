<script>
	import { createEventDispatcher } from "svelte";
	import { _ } from "svelte-i18n";
	import { Card, TableCondensed, LteButton, AutoScroll } from "svelte-adminlte";
	import JobsProvider from "../../providers/jobsProvider";

	const dispatch = createEventDispatcher();
	let jobRuns = [];
	let loading = false;
	function loadJobRuns() {
		loading = true;
		JobsProvider.getJobRuns()
			.then((res) => {
				console.log(res.data);
				if (res.data) jobRuns = res.data;
			})
			.catch((er) => console.log(er))
			.finally(() => (loading = false));
	}

	function dateWithoutSeconds(time) {
		var d = new Date();
		// d.setSeconds(0, 0);
		return d.toISOString();
	}
	loadJobRuns();
</script>

<Card outline color="primary" noPadding>
	<svelte:fragment slot="header">{$_("jobRuns.cardTitle")}</svelte:fragment>
	<div slot="tools">
		<LteButton color="info" xsmall on:click={() => loadJobRuns()}>
			<i class="fas fa-sync fa-fw" />
		</LteButton>
	</div>

	<div class="row">
		<div class="col-12">
			<AutoScroll>
				<TableCondensed>
					<tr slot="headers">
						<th class="actions">{$_("jobRuns.time")}</th>
						<th>{$_("jobRuns.job")}</th>
						<th>{$_("jobRuns.script")}</th>
						<th>{$_("jobRuns.status")}</th>
						<th>{$_("jobRuns.duration")}</th>
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
								{dateWithoutSeconds(jobRun.startTime)}
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

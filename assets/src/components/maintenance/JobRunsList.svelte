<script>
	import { createEventDispatcher } from "svelte";
	import { _ } from "svelte-i18n";
	import {
		Card,
		TableCondensed,
		LteButton,
		AutoScroll,
		Checkbox,
		Label,
	} from "svelte-adminlte";
	import JobsProvider from "../../providers/jobsProvider";
	import { jobAutoRefreshTime } from "../../constants/maintenance";

	const dispatch = createEventDispatcher();
	let jobRuns = [];
	export let loading = false;

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
		var d = new Date(time);
		d.setSeconds(0, 0);
		return d.toLocaleString();
	}
	loadJobRuns();

	let intervalId,
		autoload = true;

	function setAutoload(set) {
		//will automatically loda job runs
		if (set ?? !autoload) {
			console.log("autoload enabled ");
			intervalId = setInterval(function () {
				loadJobRuns(true);
			}, jobAutoRefreshTime ?? 60 * 1000);
		} else {
			console.log("clearing autoload");
			clearInterval(intervalId);
		}
	}

	setAutoload(true);
</script>

<Card outline color="primary" noPadding>
	<svelte:fragment slot="header">{$_("jobRuns.cardTitle")}</svelte:fragment>
	<div slot="tools">
		<div style="display: inline-block;">
			<Checkbox
				id="auto-load"
				on:click={() => setAutoload()}
				bind:checked={autoload}
			>
				<Label inputId="auto-load">{$_("jobRuns.autoLoad")}</Label>
			</Checkbox>
		</div>
		<LteButton color="info" xsmall on:click={() => loadJobRuns()}>
			<i class="fas fa-sync fa-fw" />
		</LteButton>
	</div>

	<div class="row">
		<div class="col-12">
			<AutoScroll>
				<TableCondensed class="job-runs-table">
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
								{#if jobRun.status == "Error"}
									<span class="text-danger">
										{jobRun.status}
									</span>
								{:else}
									{jobRun.status}
								{/if}
							</td>

							<td>
								{jobRun.duration / 1000}ms
							</td>
							<td class="actions">
								<LteButton
									color="info"
									xsmall
									on:click={() => dispatch("open-job", jobRun)}
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

<style lang="sass">
	:global
		.job-runs-table
			max-height: 80vh


</style>

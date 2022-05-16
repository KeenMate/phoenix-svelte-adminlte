<script>
	import { createEventDispatcher } from "svelte";
	import { _ } from "svelte-i18n";
	import {
		Card,
		TableCondensed,
		LteButton,
		Modal,
		ModalCloseButton,
	} from "svelte-adminlte";
	import JobsProvider from "../../providers/jobsProvider";

	import { HighlightSvelte } from "svelte-highlight";
	import github from "svelte-highlight/src/styles/github";
	import sql from "svelte-highlight/src/languages/sql";
	import notification from "../../providers/notificationProvider";

	const dispatch = createEventDispatcher();
	let jobs = [];
	let loading = false,
		showScript,
		hideScript;
	function loadJobs() {
		loading = true;
		JobsProvider.getJobs()
			.then((res) => {
				console.log(res.data);
				if (res.data.length) jobs = res.data;
			})
			.catch((er) => console.log(er))
			.finally(() => (loading = false));
	}
	loadJobs();

	let shownJob;
	function showCode(job) {
		console.log(job);
		showScript();
		shownJob = job;
	}

	function deleteJob(job) {
		if (loading === true) return;
		loading = true;

		JobsProvider.deleteJob(job.jobId)
			.then((res) => {
				console.log(res.data);
				notification.success(job.name, $_("localesList.deleted"));
			})
			.catch((er) => notification.error($_("localesList.deleteError")))
			.finally(() => {
				console.log("finally");
				loadJobs();
				loading = false;
			});
	}
</script>

<svelte:head>
	{@html github}
</svelte:head>

<Card outline color="primary" noPadding>
	<svelte:fragment slot="header">{$_("localesList.cardTitle")}</svelte:fragment>
	<div slot="tools">
		<LteButton color="info" xsmall on:click={() => loadJobs()}>
			<i class="fas fa-sync fa-fw" />
		</LteButton>
		<LteButton color="success" xsmall on:click={() => dispatch("add-job")}>
			{$_("jobsList.newJob")}
		</LteButton>
	</div>

	<div class="row">
		<div class="col-12">
			<TableCondensed>
				<tr slot="headers">
					<th class="actions">{$_("common.labels.actions")}</th>
					<th>{$_("common.labels.Id")}</th>
					<th>{$_("common.labels.name")}</th>
					<th>{$_("jobsList.cron")}</th>
					<th>{$_("jobsList.showScript")}</th>
				</tr>

				{#each jobs as job}
					<tr>
						<td class="actions">
							<LteButton
								color="danger"
								xsmall
								on:click={() => deleteJob(job)}
								disabled={loading}
							>
								<i class="fas fa-trash fa-fw" />
							</LteButton>
							<LteButton
								disabled={loading}
								color="success"
								xsmall
								on:click={() => dispatch("edit", job.jobId)}
							>
								<i class="fas fa-edit fa-fw" />
							</LteButton>
						</td>
						<td>
							{job.jobId}
						</td>
						<td class="title">
							{job.name}
						</td>
						<td>
							{job.cron}
						</td>

						<td class="actions">
							<LteButton color="info" xsmall on:click={() => showCode(job)} disabled={loading}>
								<i class="fas fa-eye fa-fw" />
							</LteButton>
						</td></tr
					>
				{/each}
			</TableCondensed>
		</div>
	</div>
</Card>
<Modal bind:show={showScript} bind:hide={hideScript} center>
	<span slot="header">Add car</span>

	<HighlightSvelte code={shownJob?.content || ""} language={sql} />

	<svelte:fragment slot="actions">
		<ModalCloseButton>Close</ModalCloseButton>
	</svelte:fragment>
</Modal>

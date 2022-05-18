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
	import notification from "../providers/notificationProvider";
	import JobsList from "../components/maintenance/JobsList.svelte";
	import JobRunsList from "../components/maintenance/JobRunsList.svelte";
	import AddJobModal from "../components/maintenance/AddJobModal.svelte";
	import JobsProvider from "../providers/jobsProvider";

	let addModal;
	let jobLists;
	let loading = false;
	// export let job;

	function openJob(j) {
		//TODO get job detail from server
		loading = true;
		JobsProvider.getJob(j.jobId)
			.then((res) => {
				console.log(res);
				if (res?.data) addModal.openModal(res.data);
			})
			.catch((er) => {
				console.log(er);
				notification.error(er?.msg, $_("maintenance.getJobError"));
			})
			.finally(() => (loading = false));
	}
</script>

<PageHeader>
	<svelte:fragment>
		{$_("maintenance.title")}
	</svelte:fragment>

	<svelte:fragment slot="breadcrumbs">
		<BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
		<BreadcrumbItem active>{$_("maintenance.title")}</BreadcrumbItem>
	</svelte:fragment>
</PageHeader>

<div class="row">
	<dir class="col-lg-6 col-md-12">
		<JobsList
			on:add-job={() => addModal.openModal(null)}
			bind:this={jobLists}
			{loading}
		/>
	</dir>
	<dir class="col-lg-6 col-md-12">
		<JobRunsList on:open-job={(e) => openJob(e.detail)} {loading} />
	</dir>
</div>

<AddJobModal bind:this={addModal} on:job-added={jobLists.loadJobs()} />

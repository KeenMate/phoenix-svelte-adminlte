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
		<JobsList />
	</dir>
</div>

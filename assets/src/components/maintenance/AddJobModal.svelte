<script>
	import { createEventDispatcher } from "svelte";

	import {
		Modal,
		LteButton,
		ModalCloseButton,
		Form,
		FormGroup,
		Label,
		Textarea,
		WarningAlert,
		TextInput,
	} from "svelte-adminlte";

	import { isValidCron } from "cron-validator";

	import JobsProvider from "../../providers/jobsProvider";
	import { _ } from "svelte-i18n";
	import notification from "../../providers/notificationProvider";

	const dispatch = createEventDispatcher();

	let show;
	let hide;
	let showErrorAlert;
	let error;
	export let job;
	let code, cron, script;
	let errorMsg, loading;

	$: {
		code = job?.name;
		cron = job?.cron;
		script = job?.content;
	}
	export function openModal(j) {
		job = j;
		show();
	}

	function add() {
		console.log(code);
		console.log(cron);
		console.log(script);
		if ((errorMsg = validate(code, cron, script)) !== true) {
			showErrorAlert = true;
			error = true;
			return;
		}
		loading = true;
		error = false;

		JobsProvider.addJob(code, cron, script)
			.then((res) => {
				console.log(res.data);
				notification.success(name, $_("addJobModal.added"));
			})
			.catch((er) => {
				console.log(er);
				notification.error($_("addJobModal.addedError"));
			})
			.finally(() => {
				loading = false;
				hide();
			});
	}

	function validate(code, cron, script) {
		if (!code || code?.length <= 0) return "code cant be empty";

		if (code.includes(" ")) return "code cant include spaces";

		if (!isValidCron(cron)) return "cron not valid";

		if (script?.length <= 0) return "script cant be empty";

		return true;
		//TODO check other
	}

	function update() {
		console.log(code);
		console.log(cron);
		console.log(script);
		if ((errorMsg = validate(code, cron, script)) !== true) {
			showErrorAlert = true;
			error = true;
			return;
		}
		loading = true;
		error = false;

		JobsProvider.addJob(code, cron, script)
			.then((res) => {
				console.log(res.data);
				notification.success(name, $_("addJobModal.added"));
				dispatch("job-added");
			})
			.catch((er) => {
				console.log(er);
				notification.error($_("addJobModal.addedError"));
			})
			.finally(() => {
				loading = false;
				hide();
			});
	}
   </script>

<Modal bind:show bind:hide center>
	<span slot="header"
		>{#if job?.jobId ?? false}
			{$_("addJobModal.editTitle")}
		{:else}
			{$_("addJobModal.addTitle")}
		{/if}</span
	>

	<Form id="add-job">
		<FormGroup>
			<Label inputId="code">name with underscores instrad of spaces</Label>

			<TextInput placeholder="code" id="code" bind:value={code} {loading} />
		</FormGroup>
		<FormGroup>
			<Label inputId="cron">Schedule (cron expresion)</Label>

			<TextInput placeholder="cron" id="cron" bind:value={cron} {loading} />
		</FormGroup>
		<FormGroup>
			<Label inputId="script">sql code</Label>

			<Textarea
				class="add-job-textarea"
				placeholder="script"
				id="script"
				bind:value={script}
				rows={5}
				{loading}
			/>
		</FormGroup>
	</Form>

	{#if showErrorAlert && error}
		<WarningAlert closeable={false}>
			<i class="icon fas fa-exclamation-triangle" />
			{errorMsg}

			<button
				type="button"
				class="close"
				on:click={() => (showErrorAlert = false)}>×</button
			>
		</WarningAlert>
	{/if}

	<svelte:fragment slot="actions">
		<ModalCloseButton>Close</ModalCloseButton>
		{#if job?.jobId ?? false}
			<!-- <LteButton
				type="submit"
				form="add-car"
				color="success"
				small
				on:click={update}
				disabled={loading}>Update</LteButton
			> -->
		{:else}
			<LteButton
				type="submit"
				form="add-car"
				color="success"
				small
				on:click={add}
				disabled={loading}>Add</LteButton
			>
		{/if}
	</svelte:fragment>
</Modal>

<style>
	:global(.add-job-textarea) {
		height: auto;
	}
</style>

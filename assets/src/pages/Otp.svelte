<script>
	import { OneTimePass } from "svelte-otp";
	import {
		PageHeader,
		BreadcrumbItem,
		Card,
		FormGroup,
		Label,
		TextInput,
		NumberInput,
		Checkbox,
	} from "svelte-adminlte";
	import { _ } from "svelte-i18n";
	import InputGroup from "svelte-adminlte/src/form/structure/InputGroup.svelte";

	let value,
		onlyNumbers = true,
		chunksCount = 3,
		chunkLength = 3,
		valueWithSeparators,
		isComplete;
</script>

<PageHeader>
	<svelte:fragment>
		{$_("otp.title")}
	</svelte:fragment>

	<svelte:fragment slot="breadcrumbs">
		<BreadcrumbItem><a href="#/">{$_("otp.title")}</a></BreadcrumbItem>
		<BreadcrumbItem active>
			{$_("otp.title")}
		</BreadcrumbItem>
	</svelte:fragment>
</PageHeader>
<div class="row">
	<div class="col-md-6 col-12">
		<Card outline color="info">
			<svelte:fragment slot="header">Demo</svelte:fragment>

			<OneTimePass
				bind:value
				bind:onlyNumbers
				bind:chunksCount
				{chunkLength}
				bind:valueWithSeparators
				bind:isComplete
			/>
		</Card>
	</div>

	<div class="col-md-6 col-12">
		<Card outline color="success">
			<svelte:fragment slot="header">Options</svelte:fragment>
			<FormGroup>
				<Label>value</Label>
				<InputGroup>
					<div class="col-6">
						<TextInput type="text" bind:value={valueWithSeparators} disabled />
					</div>
					<div class="col-6">
						{JSON.stringify(value)}
					</div>
				</InputGroup>
			</FormGroup>
			<FormGroup>
				<Checkbox
					bind:checked={isComplete}
					id="isComplete"
					disabled
					level="success"
					><Label inputId="isComplete">isComplete</Label></Checkbox
				>
			</FormGroup>
			<FormGroup>
				<Checkbox bind:checked={onlyNumbers} id="onlyNumbers"
					><Label inputId="onlyNumbers">onlyNumbers</Label></Checkbox
				>
			</FormGroup>

			<FormGroup
				><Label>chunks</Label><NumberInput
					type="number"
					bind:value={chunksCount}
				/></FormGroup
			>
			<FormGroup
				><Label>chunkLength</Label>
				<NumberInput type="number" bind:value={chunkLength} /></FormGroup
			>
		</Card>
	</div>
</div>

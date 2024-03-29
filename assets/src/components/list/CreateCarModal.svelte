<script>
  import { createForm } from "felte";
  import { validator } from "@felte/validator-zod";
  import { svelteReporter, ValidationMessage } from "@felte/reporter-svelte";
  import * as zod from "zod";
  import { createEventDispatcher } from "svelte";

  import SvelteSelect from "svelte-select";
  import {
    Modal,
    LteButton,
    ModalCloseButton,
    Form,
    FormGroup,
    Label,
    NumberInput,
    WarningAlert,
    Checkbox,
  } from "svelte-adminlte";

  const dispatch = createEventDispatcher();

  let show;
  let hide;
  let showErrorAlert = false;
  let oldManufacturer = "";
  let availableModels = [];

  const manufacturers = [
    { value: "toyota", label: "Toyota" },
    { value: "subaru", label: "Subaru" },
    { value: "lexus", label: "Lexus" },
    { value: "volkswagen", label: "Volkswagen" },
  ];

  const models = {
    toyota: [
      { label: "Prius", value: "prius" },
      { label: "Yaris", value: "yaris" },
      { label: "Corolla", value: "corolla" },
      { label: "Camry", value: "camry" },
    ],
    subaru: [
      { label: "Impreza", value: "impreza" },
      { label: "BRZ", value: "brz" },
    ],
    lexus: [
      { label: "LFA", value: "lfa" },
      { label: "RX", value: "rx" },
    ],
    volkswagen: [
      { label: "Up!", value: "up" },
      { label: "Golf", value: "golf" },
      { label: "Passat", value: "Passat" },
    ],
  };

  const selectValue = zod.object({
    label: zod.string(),
    value: zod.string(),
  });

  const schema = zod.object({
    manufacturer: selectValue,
    model: selectValue,
    year: zod.number().gte(1850).lte(new Date().getFullYear()).optional(),
  });

  const { form, isValid, errors, reset, data, setField, touched, setTouched } = createForm({
    extend: [validator, svelteReporter, errorAlertExtender],
    validate: [
      (values) => {
        let errors = {};

        if (values.requireYear && !values.year) {
          errors.year = ["Year is required"];
        }

        return errors;
      },
    ],
    validateSchema: schema,
    initialValues: {
      manufacturer: "",
      model: "",
    },
    onSubmit(values) {
      dispatch("add", mapToCar(values));
      reset();
      hide();
    },
  });

  $: if ($isValid) {
    showErrorAlert = false;
  }

  $: {
    if (!$data.manufacturer && oldManufacturer != "") {
      clearModel();
      availableModels = [];
      oldManufacturer = "";
    } else if ($data.manufacturer.value != oldManufacturer) {
      clearModel();
      oldManufacturer = $data.manufacturer.value;
      availableModels = models[$data.manufacturer.value];
    }
  }

  export function openModal() {
    show();
  }

  function clearForm() {
    reset();
  }

  function clearModel() {
    $data.model = "";
  }

  function errorAlertExtender() {
    return {
      onSubmitError(errors) {
        showErrorAlert = true;
      },
    };
  }

  function mapToCar(values) {
    return { manufacturer: values.manufacturer.label, model: values.model.label, year: values.year };
  }
</script>

<Modal bind:show bind:hide center>
  <span slot="header">Add car</span>

  <Form id="add-car" {form}>
    <FormGroup>
      <Checkbox level="danger" name="requireYear" id="requireYear">
        <Label inputId="requireYear">Require year</Label>
      </Checkbox>
    </FormGroup>

    <FormGroup>
      <Label>Manufacturer</Label>
      <ValidationMessage for="manufacturer" let:messages>
        <SvelteSelect bind:value={$data.manufacturer} items={manufacturers} hasError={messages} />

        <!-- <TextInput invalid={messages} name="manufacturer" id="manufacturer" /> -->

        <span class="error invalid-feedback">{messages}</span>
      </ValidationMessage>
    </FormGroup>

    <FormGroup>
      <Label>Model</Label>
      <ValidationMessage for="model" let:messages>
        <SvelteSelect
          isDisabled={!$data.manufacturer}
          bind:value={$data.model}
          items={availableModels}
          hasError={messages}
        />

        <span class="error invalid-feedback">{messages}</span>
      </ValidationMessage>
    </FormGroup>

    <FormGroup>
      <Label>Year</Label>
      <ValidationMessage for="year" let:messages>
        <NumberInput name="year" id="year" invalid={messages} />

        <span class="error invalid-feedback">{messages}</span>
      </ValidationMessage>
    </FormGroup>
  </Form>

  {#if showErrorAlert && !$isValid}
    <WarningAlert closeable={false}>
      <i class="icon fas fa-exclamation-triangle" />Please fix your input

      <button type="button" class="close" on:click={() => (showErrorAlert = false)}>×</button>
    </WarningAlert>
  {/if}

  <svelte:fragment slot="actions">
    <ModalCloseButton>Close</ModalCloseButton>
    <LteButton type="submit" form="add-car" color="success" small>Add</LteButton>
  </svelte:fragment>
</Modal>

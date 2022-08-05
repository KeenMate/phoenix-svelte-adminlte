<script>
  import {
    TextInput,
    Form,
    FormGroup,
    Label,
    DateRangePicker,
    FileInput,
    InputGroup,
    InputGroupPrepend,
  } from "@keenmate/svelte-adminlte";
  import SvelteSelect from "svelte-select";

  const categoryItems = [
    { value: "adventure", label: "Adventure" },
    { value: "action", label: "Action" },
    { value: "sci-fi", label: "Sci-Fi" },
    { value: "comedy", label: "Comedy" },
    { value: "drama", label: "Drama" },
  ];

  export let user;

  let dateRangePickerElement = null;

  let listOpen = false;
  let isFocused = false;

  $: {
    if (!listOpen && isFocused) listOpen = true;
  }
</script>

<Form>
  <div class="row">
    <div class="col-6">
      <FormGroup>
        <Label class="pb-1">First name</Label>
        <TextInput bind:value={user.first_name} />
      </FormGroup>
    </div>
    <div class="col-6">
      <FormGroup>
        <Label class="pb-1">Last name</Label>
        <TextInput bind:value={user.last_name} />
      </FormGroup>
    </div>
  </div>
  <div class="row">
    <div class="col-6">
      <FormGroup>
        <Label class="pb-1">Gender</Label>
        <div class="svelte-select">
          <SvelteSelect
            items={[
              { value: "male", label: "Male" },
              { value: "female", label: "Female" },
              { value: "other", label: "Other" },
            ]}
          />
        </div>
      </FormGroup>
    </div>
    <div class="col-6">
      <FormGroup>
        <Label class="pb-1">Birth date</Label>

        <DateRangePicker
          startDate={user.birth_day}
          inputElement={dateRangePickerElement}
        >
          <InputGroup>
            <InputGroupPrepend>
              <span class="input-group-text">
                <i class="far fa-calendar-alt" />
              </span>
            </InputGroupPrepend>
            <TextInput bind:inputElement={dateRangePickerElement} />
          </InputGroup>
        </DateRangePicker>

        <!-- <DateRangePicker
          startDate={user.birthDay}
          singleDatePicker
          inputElement={dateRangePickerElement}
          on:change={({ detail: { date: d } }) => (user.birthDay = d.format("DD/MM/YYYY"))}
        >
          <InputGroup>
            <InputGroupPrepend>
              <span class="input-group-text">
                <i class="far fa-calendar-alt" />
              </span>
            </InputGroupPrepend>
            <TextInput bind:inputElement={dateRangePickerElement} />
          </InputGroup>
        </DateRangePicker> -->
      </FormGroup>
    </div>
  </div>
  <div class="row">
    <div class="col-6">
      <FormGroup>
        <Label class="pb-1">Avatar</Label>

        <FileInput bind:value={user.avatar}>Pick avatar...</FileInput>
      </FormGroup>
    </div>
    <div class="col-6">
      <FormGroup>
        <Label class="pb-1">Phone number</Label>
        <InputGroup>
          <InputGroupPrepend>
            <span class="input-group-text"><i class="fas fa-phone" /></span>
          </InputGroupPrepend>
          <TextInput
            inputMask="'mask': '999 999 999'"
            bind:value={user.phone}
            size="md"
          />
        </InputGroup>
      </FormGroup>
    </div>
  </div>

  <div class="row">
    <div class="col-6">
      <FormGroup>
        <Label class="pb-1">Favorite categories</Label>
        <div class="svelte-select">
          <SvelteSelect
            bind:listOpen
            bind:isFocused
            items={categoryItems}
            isMulti
            isCreatable
          />
        </div>
      </FormGroup>
    </div>
  </div>
</Form>

<style>
  :global(.svelte-select) {
    --borderRadius: 4px;
    --height: calc(2.25rem + 2px);
    --multiItemBorderRadius: 8px;
    --multiSelectPadding: 0 25px 0 6px;
    --multiItemPadding: 0 7px 0 7px;
    --multiItemHeight: 26px;
    --multiClearTop: 6px;
    --clearSelectTop: 5px;
    /* --placeholderColor: blue; */
  }
</style>

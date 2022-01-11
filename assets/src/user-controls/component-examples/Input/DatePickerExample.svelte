<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import { DateRangePicker, TextInput } from "svelte-adminlte";

  let data = {
    name: "DatePicker",
    text: "[DateRangePicker](#/components/show/date-range-picker) in single date mode. **Props and event are same as in [DateRangePicker](#/components/show/date-range-picker). You can see them there.**",
    props: [
      {
        name: "inputElement",
        type: "HTMLElement",
        comment:
          "Bind the datepicker to a element. Also is possible to bind to any element (not input) for example you need inline calendar.",
      },
      {
        name: "startDate",
        type: "Date | Number | String",
        comment:
          "Preselect date.If option singleMode is disabled then endDate must be set too.",
      },
      {
        name: "endDate",
        type: "Date | Number | String",
        comment: "Preselect end date.Required startDate.",
      },
      {
        name: "minDate",
        type: "Date | Number | String",
        comment: "The minimum/earliest date that can be selected.",
      },
      {
        name: "maxDate",
        type: "Date | Number | String",
        comment: "The maximum/latest date that can be selected.",
      },
      {
        name: "position",
        type: "string",
        comment:
          "A space-separated string consisting of one or two of left or right, top or bottom, and auto (may be omitted).",
      },
      {
        name: "single",
        type: "bool",
        comment: "**must be set to true to select date instead of daterange**",
      },
      { name: "disabled", type: "bool", comment: "" },
      {
        name: "visibleMonths",
        type: "Number",
        comment: "Number of visible months.",
      },
      { name: "columns", type: "Number", comment: "Number of columns months." },
      {
        name: "lockDaysFilter",
        type: "Functions",
        comment:
          "viz litepicker [documentation](https://litepicker.com/docs/options#lockdaysfilter-200). Return true for date to be disabled",
      },
      { name: "lockDays", type: "Array", comment: "" },
    ],
    examples: {
      single: {
        name: "single date selection",
        code: "<DateRangePicker inputElement={inputElement1} single={true}> <TextInput bind:inputElement={inputElement1}/> </DateRangePicker>",
      },
      minmax: {
        name: "minimal and maximal dates",
        code: '<DateRangePicker inputElement={inputElement2} minDate="11-5-2021" maxDate="1-15-2022" position="auto" single> <TextInput bind:inputElement={inputElement2}/> </DateRangePicker>',
      },
      filter: {
        name: "filtering dates using filter function",
        code: '<DateRangePicker\r\n  inputElement={inputElement}\r\n  minDate="11-5-2021"\r\n  maxDate="1-15-2022"\r\n  position="auto"\r\n  single\r\n  lockDaysFilter={filterfunction}\r\n>\r\n  <TextInput bind:inputElement={inputElement3} />\r\n</DateRangePicker>',
      },
    },
  };
  //   export let lockDaysFilter = undefined;
  // export let lockDays = [];

  let inputElement, inputElement1, inputElement2, inputElement3;

  let filterfunction = (day) => {
    const d = day.getDay();

    return [6, 0].includes(d);
  };
</script>

<ComponentPageTemplate
  text={data.text}
>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.single.code}
      name={data.examples.single.name}
    >
      <DateRangePicker inputElement={inputElement1} single position="auto">
        <TextInput bind:inputElement={inputElement1} />
      </DateRangePicker>
    </ComponentExampleTemplate><ComponentExampleTemplate
      code={data.examples.minmax.code}
      name={data.examples.minmax.name}
    >
      <DateRangePicker
        inputElement={inputElement2}
        minDate="11-5-2021"
        maxDate="1-15-2022"
        position="auto"
        single
      >
        <TextInput bind:inputElement={inputElement2} />
      </DateRangePicker>
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.filter.code}
      name={data.examples.filter.name}
    >
      <DateRangePicker
        inputElement={inputElement3}
        minDate="11-5-2021"
        maxDate="1-15-2022"
        position="auto"
        single
        lockDaysFilter={filterfunction}
      >
        <p>example of using function to filter out weekends</p>
        <TextInput bind:inputElement={inputElement3} />
      </DateRangePicker>
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

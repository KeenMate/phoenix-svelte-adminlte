<script>
    import ComponentPageTemplate from "../controls/Components/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../controls/Components/ComponentExampleTemplate.svelte";
    
    import {DateRangePicker,TextInput} from "svelte-adminlte"
  
    let data = {
      name: "DatePicker",
      text: "[DateRangePicker](#/components/show/date-range-picekr) in sigle date mode",
      props: [
        { name: "inputElement", type: "HTMLElement", comment: "Bind the datepicker to a element. Also is possible to bind to any element (not input) for example you need inline calendar." },
        { name: "startDate", type: "Date | Number | String", comment: "Preselect date.If option singleMode is disabled then endDate must be set too." },
        { name: "endDate", type: "Date | Number | String", comment: "Preselect end date.Required startDate." },
        { name: "minDate", type: "Date | Number | String", comment: "The minimum/earliest date that can be selected." },
        { name: "maxDate", type: "Date | Number | String", comment: "The maximum/latest date that can be selected." },
        { name: "position", type: "string", comment: "A space-separated string consisting of one or two of left or right, top or bottom, and auto (may be omitted)." },
        { name: "single", type: "bool", comment: "**must be set to true to select date instead of daterange**" },
        { name: "disabled", type: "bool", comment: "" },
        { name: "visibleMonths", type: "Number", comment: "Number of visible months." },
        { name: "collumns", type: "Number", comment: "Number of columns months." },
        ],
      examples: {
        single: {
          name: "single date selection",
          code: '<DateRangePicker inputElement={inputElement} single={true}> <TextInput bind:inputElement={inputElement}\/> <\/DateRangePicker>',
        },
        minmax: {
          name: "minimal and maximal dates",
          code: '<DateRangePicker inputElement={inputElement3} minDate=\"11-5-2021\" maxDate=\"1-15-2022\" position=\"auto\" single> <TextInput bind:inputElement={inputElement3}/> </DateRangePicker>',
        }
        
      },
    };
  
    let inputElement, inputElement1,inputElement2, inputElement3;
  </script>
  
  <ComponentPageTemplate
    text={data.text}
    properties={data.props}
    events={data.events}
  >
    <svelte:fragment slot="examples">
     <ComponentExampleTemplate
      code={data.examples.single.code}
      name={data.examples.single.name}
    >
      <DateRangePicker inputElement={inputElement2} single position="auto"> <TextInput bind:inputElement={inputElement2}/> </DateRangePicker>
    </ComponentExampleTemplate><ComponentExampleTemplate
    code={data.examples.minmax.code}
    name={data.examples.minmax.name}
  >
    <DateRangePicker inputElement={inputElement3} minDate="11-5-2021" maxDate="1-15-2022" position="auto" single> <TextInput bind:inputElement={inputElement3}/> </DateRangePicker>
  </ComponentExampleTemplate>
    </svelte:fragment></ComponentPageTemplate
  >
  
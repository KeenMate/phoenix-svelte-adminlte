<script>
    import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
    import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";
    
    import {DateRangePicker,TextInput} from "svelte-adminlte"
  
    export const data = {
      name: "DateRangePicker",
      text: "DateRangePicker is [litePicker](https://litepicker.com/) wrapped in svelte for easier usage.For single date see [DatePicker](#/components/show/date-picker)",
      props: [
        { name: "inputElement", type: "HTMLElement", comment: "Bind the datepicker to a element. Also is possible to bind to any element (not input) for example you need inline calendar." },
        { name: "startDate", type: "Date | Number | String", comment: "Preselect date.If option singleMode is disabled then endDate must be set too." },
        { name: "endDate", type: "Date | Number | String", comment: "Preselect end date.Required startDate." },
        { name: "minDate", type: "Date | Number | String", comment: "The minimum/earliest date that can be selected." },
        { name: "maxDate", type: "Date | Number | String", comment: "The maximum/latest date that can be selected." },
        { name: "position", type: "string", comment: "A space-separated string consisting of one or two of left or right, top or bottom, and auto (may be omitted)." },
        { name: "single", type: "bool", comment: "Choose a single date instead of a date range." },
        { name: "disabled", type: "bool", comment: "" },
        { name: "visibleMonths", type: "Number", comment: "Number of visible months." },
        { name: "columns", type: "Number", comment: "Number of columns months." },
        { name: "....", type: "", comment: "Rest of properties can be found at [litepicker.com/docs/options](https://litepicker.com/docs/options)" },
        ],
      events:[
        {name:"selected",comment:"Event is called when selection is submitted.", params:"{start: startDate, end: endDate}"},
        {name:"show",comment:"Event is called after show.", params:"ui (root element of picker)"},
        {name:"render",comment:"Event is called after render function.", params:"el (triggered element)"},
        {name:"apply",comment:"Event is called after click on button apply (footer).", params:"{start: startDate, end: endDate}"},
        ],
      examples: {
        minimal: {
          name: "minimal usage",
          code: '<DateRangePicker inputElement={inputElement}> <TextInput bind:inputElement={inputElement}\/> <\/DateRangePicker>',
        },
        basic: {
          name: "visual stuff customised",
          code: '<DateRangePicker inputElement={inputElement} visibleMonths={1} columns={1} position=\"auto\"> <TextInput bind:inputElement={inputElement}\/> <\/DateRangePicker>',
        },
        minmax:{
          name:"minimal and maximal date",
          code:"<DateRangePicker inputElement={inputElement3} minDate={getmindate()} maxDate={getmaxdate()} position=\"auto\" > <TextInput bind:inputElement={inputElement3}/> </DateRangePicker>"
        }
       
        
      },
    };
    function getmindate(){
      var ourDate = new Date();
      ourDate.setDate(ourDate.getDate() - 7);
      console.log(ourDate.toISOString())
      return ourDate.toISOString();
    }
    function getmaxdate(){
      var ourDate = new Date();
      ourDate.setDate(ourDate.getDate() + 7);
      console.log(ourDate.toISOString())
      return ourDate.toISOString();
    }
  
    let inputElement, inputElement1,inputElement2, inputElement3;
  </script>
  
  <ComponentPageTemplate
    text={data.text}
    properties={data.props}
    events={data.events}
  >
    <svelte:fragment slot="examples">
      <ComponentExampleTemplate
        code={data.examples.minimal.code}
        name={data.examples.minimal.name}
      >
        <DateRangePicker inputElement={inputElement}> <TextInput bind:inputElement={inputElement}/> </DateRangePicker>
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
        code={data.examples.basic.code}
        name={data.examples.basic.name}
      >
        <DateRangePicker inputElement={inputElement1} visibleMonths={1} columns={1} position="auto"> <TextInput bind:inputElement={inputElement1}/> </DateRangePicker>
      </ComponentExampleTemplate>
      <ComponentExampleTemplate
      code={data.examples.minmax.code}
      name={data.examples.minmax.name}
    >
      <DateRangePicker inputElement={inputElement3} minDate={getmindate()} maxDate={getmaxdate()} position="auto" > <TextInput bind:inputElement={inputElement3}/> </DateRangePicker>
    </ComponentExampleTemplate>
    </svelte:fragment></ComponentPageTemplate
  >
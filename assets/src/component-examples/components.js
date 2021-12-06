
import CardExample from "./CardExample.svelte";
import TextInputExample from "./TextInputExample.svelte"
import CheckboxExample from "./CheckboxExample.svelte"
import CkEditorExample from "./CkEditorExample.svelte"
import DateRangePicketExample from "./DateRangePicketExample.svelte"
import DatePickerExample from "./DatePickerExample.svelte"
//import DropdownExample from "./DropdownExample.svelte"
import EmailInputExample from "./EmailInputExample.svelte"
import FileInputExample from "./FileInputExample.svelte"
//import MultiselectExample from "./MultiselectExample.svelte"
import NumberInputExample from "./NumberInputExample.svelte"
import RadioExample from "./RadioExample.svelte"

export const components = [
    {name:"Card", code:"card", component: CardExample,category: "Structure", 
        description:"Make everything look better"},
    {name:"TextInput",code:"text-input", component: TextInputExample, category:"Input", 
        description:"Text input made into svelte component"},
    {name:"Checkbox", code:"checkbox", component: CheckboxExample, category:"Input", 
        description:"Checkbox input"},
    {name:"CkEditor", code:"ckeditor", component: CkEditorExample, category:"Input", 
        description:"Simple but rich text editor"},
    {name:"DateRangePicket", code:"date-range-picker", component: DateRangePicketExample, category:"Input", 
        description:"Date range picker using Litepicker"},
    {name:"DatePicker", code:"date-picker", component: DatePickerExample, category:"Input", 
        description:"single date picker using Litepicker",breadcrumb:"[DateRangePicker](#/components/show/date-range-picker)"},
    
    //{name:"Dropdown", code:"dropdown", component: DropdownExample, category:"Input", description:"Select 2 Dropdown"},
    {name:"EmailInput",code:"email-input-example",component: EmailInputExample, category:"Input",
        description:"Email Input"},
    {name:"FileInput", code:"file-input", component: FileInputExample,category: "Input", 
        description:"File input for uploading one or more files"},
    // {name:"Multiselect", code:"multiselect", component: MultiselectExample,category: "Input", 
    //     description:"Multiselect using select2"},
    {name:"NumberInput", code:"number-input", component: NumberInputExample,category: "Input", 
        description:"input with type number"},
    {name:"RadioExample", code:"radio", component: RadioExample,category: "Input", 
        description:"input with type radio"},

] 

export const categories = ["Structure","Input"]
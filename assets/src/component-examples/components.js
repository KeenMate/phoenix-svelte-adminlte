
//! input
    import TextInputExample from "./Input/TextInputExample.svelte"
    import CheckboxExample from "./Input/CheckboxExample.svelte"
    import CkEditorExample from "./Input/CkEditorExample.svelte"
    import DateRangePicketExample from "./Input/DateRangePicketExample.svelte"
    import DatePickerExample from "./Input/DatePickerExample.svelte"
    //import DropdownExample from "./DropdownExample.svelte"
    import EmailInputExample from "./Input/EmailInputExample.svelte"
    import FileInputExample from "./Input/FileInputExample.svelte"
    //import MultiselectExample from "./MultiselectExample.svelte"
    import NumberInputExample from "./Input/NumberInputExample.svelte"
    import RadioExample from "./Input/RadioExample.svelte"
    import SwitchExample from "./Input/SwitchExample.svelte"
    import TextareaExample from "./Input/TextareaExample.svelte"
    import UploadModalExample from "./UploadModalExample.svelte"
    import PhoneFieldExample from "./Input/PhoneFieldExample.svelte"
//! form
    import FormExamle from "./Form/FormExample.svelte"
    import FormGroupExamle from "./Form/FormGroupExample.svelte"
    import InputGroupExamle from "./Form/InputGroupExample.svelte"
    import LabelExample from "./Form/LabelExample.svelte"
//! structure
    import CardExample from "./Structure/CardExample.svelte";
    import FlexContainerExample from "./Structure/FlexContainerExample.svelte";
    import ModalExample from "./Structure/ModalExample.svelte"
    
    
export const components = [
//! input
    {name:"TextInput",code:"text-input", component: TextInputExample, category:"Input", 
        description:"Text input made into svelte component"},
    {name:"Checkbox", code:"checkbox", component: CheckboxExample, category:"Input", 
        description:"Checkbox input"},
    {name:"CkEditor", code:"ckeditor", component: CkEditorExample, category:"Input", 
        description:"Simple but rich text editor"},
    {name:"DateRangePicker", code:"date-range-picker", component: DateRangePicketExample, category:"Input", 
        description:"Date range picker using Litepicker"},
    {name:"DatePicker", code:"date-picker", component: DatePickerExample, category:"Input", 
        description:"Single date picker using Litepicker",breadcrumb:"[DateRangePicker](#/components/show/date-range-picker)"},
    
    //{name:"Dropdown", code:"dropdown", component: DropdownExample, category:"Input", description:"Select 2 Dropdown"},
    {name:"EmailInput",code:"email-input-example",component: EmailInputExample, category:"Input",
        description:"Email Input"},
    {name:"FileInput", code:"file-input", component: FileInputExample,category: "Input", 
        description:"File input for uploading one or more files"},
    // {name:"Multiselect", code:"multiselect", component: MultiselectExample,category: "Input", 
    //     description:"Multiselect using select2"},
    {name:"NumberInput", code:"number-input", component: NumberInputExample,category: "Input", 
        description:"Input with type number"},
    {name:"Radio", code:"radio", component: RadioExample,category: "Input", 
        description:"Input with type radio"},
    {name:"Switch", code:"switch", component: SwitchExample,category: "Input", 
        description:"Switch with slider"},
    {name:"Textarea", code:"textarea", component: TextareaExample,category: "Input", 
        description:"Input with type textarea"},
    {name:"UploadModalExample", code:"upload-modal", component: UploadModalExample,category: "Input", 
        description:"upload using uppy.io"},
    {name:"PhoneField", code:"phone-field", component: PhoneFieldExample,category: "Input", 
        description:"Phone field"},
//! form
    {name:"Form", code:"form", component: FormExamle, category:"Form",
        description:"Form element "},
    {name:"FormGroup", code:"form-group", component: FormGroupExamle, category:"Form",
        description:"Form group "},
    {name:"InputGroup", code:"input-group", component: InputGroupExamle, category:"Form",
        description:"Input group"},
    {name:"Label", code:"label", component: LabelExample, category:"Form",
        description:"Label"},

//! structure
    {name:"Card", code:"card", component: CardExample,category: "Structure", 
        description:"Make everything look better"},
    {name:"FlexContainer", code:"flex-container", component: FlexContainerExample,category: "Structure", 
        description:"CSS display: flex"},
    {name:"Modal", code:"modal", component: ModalExample,category: "Structure", 
        description:"full page modal "},
] 

export const categories = ["Structure","Input","Form"]

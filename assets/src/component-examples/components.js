
import CardExample from "./CardExample.svelte";
import TextInputExample from "./TextInputExample.svelte"
import CheckboxExample from "./CheckboxExample.svelte"

export const components = [
    {name:"Card", code:"card", component: CardExample,category: "Structure", description:"Make everything look better"},
    {name:"TextInput",code:"text-input", component: TextInputExample, category:"Input", description:"Text input made into svelte component"},
    {name:"Checkbox", code:"checkbox", component: CheckboxExample, category:"Input", description:"Checkbox input"}
] 

export const categories = ["Structure","Input"]
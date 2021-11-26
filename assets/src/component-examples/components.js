
import CardExample from "./CardExample.svelte";
import TextInputExample from "./TextInputExample.svelte"


export const components = [
    {name:"Card", code:"card", component: CardExample,category: "Structure", description:"Make everything look better"},
    {name:"TextInput",code:"text-input", component: TextInputExample, category:"Input", description:"text input made into svelte component"}

] 

export const categories = ["Structure","Input"]
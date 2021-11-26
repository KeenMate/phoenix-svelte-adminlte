
import CardExample from "./CardExample.svelte";
import TextInputExample from "./TextInputExample.svelte"


export const components = [
    {name:"Card", code:"card", component: CardExample,category: "structure", description:"Make everything look better"},
    {name:"TextInput",code:"text-input", component: TextInputExample, category:"input", description:"text input made into svelte component"}

] 

export const categories = ["structure","input"]
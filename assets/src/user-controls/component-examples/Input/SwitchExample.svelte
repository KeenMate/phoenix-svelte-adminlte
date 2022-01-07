<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";
  import notification from "../../../providers/notificationProvider";
  import { Switch, TableCondensed, Checkbox, Label } from "svelte-adminlte";
  import SvelteSelect from "svelte-select";
  let data = {
    name: "Switch Example",
    text: "",
    props: [
      { name: "checked", type: "string", comment: "" },
      {
        name: "checkedClass",
        type: "string",
        comment:
          "Use classes that add backgroud-color (bg-red ,bg-primary, atd.).",
      },
      {
        name: "uncheckedClass",
        type: "string",
        comment:
          "Use classes that add backgroud-color (bg-red ,bg-primary, atd.).",
      },
      {
        name: "disabledClass",
        type: "string",
        comment:
          "Use classes that add backgroud-color (bg-red ,bg-primary, atd.).",
      },
    ],
    events: [
      { name: "change", comment: "value changed", params: "" },
      { name: "checked", comment: "value changed to true", params: "" },
      { name: "unchecked", comment: "value changed to false", params: "" },
    ],
    examples: {
      minimal: {
        name: "Usage",
        code: "<Switch bind:checked1 />",
      },
      disabled: {
        name: "Disabled",
        code: "<Checkbox bind:checked={dis} id=\"dis\"\r\n  ><Label inputId=\"dis\">Disabled<\/Label><\/Checkbox\r\n>\r\n<Switch\r\n  disabled={dis}\r\n  disabledClass=\"bg-light\"\r\n  checkedClass=\"bg-success\"\r\n  uncheckedClass=\"bg-danger\"\r\n\/>",
      },
      event: {
        name: "Events ",
        code: '<Switch\r\n  bind:checked2\r\n  checkedClass="bg-green"\r\n  on:change={(e) => {\r\n    console.log("CHANGED");\r\n    notify("changed");\r\n  }}\r\n  on:checked={(e) => {\r\n    notify("checked");\r\n  }}\r\n  on:unchecked={(e) => {\r\n    notify("unchecked");\r\n  }}\r\n/>',
      },
      color: {
        name: "colors",
        code: '<TableCondensed>\r\n<svelte:fragment slot="headers">\r\n  <tr>\r\n    <th>checked</th>\r\n    <th>unchecked</th>\r\n    <th>switch</th>\r\n  </tr>\r\n</svelte:fragment>\r\n{#each colors as color}\r\n  <tr>\r\n    <td>{color.f}</td>\r\n    <td>{color.s}</td>\r\n    <td>\r\n      <Switch checkedClass={color.f} \r\n      uncheckedClass={color.s} />\r\n\r\n    </td>\r\n  </tr>\r\n{/each}\r\n</TableCondensed>',
      },
    },
  };
  function notify(text) {
    console.log("NOTIFY");
    notification.success(text);
  }
  let colors = [
    { f: "bg-primary", s: "bg-secondary", d: "bg-muted" },
    { f: "bg-success", s: "bg-danger" , d: "bg-muted"},
    { f: "bg-danger", s: "bg-dark" , d: "bg-muted"},
    { f: "bg-warning  ", s: "bg-muted" , d: "bg-muted"},
    { f: "bg-info", s: "bg-dark", d: "bg-muted" },
  ];

  let bgcolors = [
    "bg-primary",
    "bg-secondary",
    "bg-success",
    "bg-danger",
    "bg-warning",
    "bg-info",
    "bg-light",
    "bg-dark",
    "bg-muted",
    "bg-white",
  ];
  let checked1,
    checked2,
    checkedColor,
    uncheckedColor,
    disabledColor,
    dis = true;



    
    function getCode(checkedClass,uncheckedClass,disabledClass){
      return `<Switch disabledClass=\"${disabledClass?.value || ""}\" checkedClass=\"${checkedClass?.value || ""}\" uncheckedClass=\"${uncheckedClass?.value || ""}\"\/\>`
    }
    let generatedCode = null;
    $: generatedCode = getCode(checkedColor,uncheckedColor,disabledColor)
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
      <Switch bind:checked={checked1} />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.disabled.code}
      name={data.examples.disabled.name}
    >
<Checkbox bind:checked={dis} id="dis"
  ><Label inputId="dis">Disabled</Label></Checkbox
>
<Switch
  disabled={dis}
  disabledClass="bg-light"
  checkedClass="bg-success"
  uncheckedClass="bg-danger"
/>
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.event.code}
      name={data.examples.event.name}
    >
      <Switch
        bind:checked={checked2}
        checkedClass="bg-green"
        on:change={(e) => {
          console.log("CHANGED");
          notify("changed");
        }}
        on:checked={(e) => {
          notify("checked");
        }}
        on:unchecked={(e) => {
          notify("unchecked");
        }}
      />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate 
    name={data.examples.color.name}
    code={generatedCode}
    exampleOnly>
    
      <TableCondensed>
        <svelte:fragment slot="headers">
          <tr>
            <th class="col-3">unchecked</th>
            <th class="col-3">checked</th>
            <th class="col-3">disabled</th>
            <th class="col-3">switch</th>
          </tr>
        </svelte:fragment>
        <tr>
          <td class="col-3">
            <SvelteSelect items={bgcolors} bind:value={uncheckedColor} />
          </td>
          <td class="col-3">
            <SvelteSelect items={bgcolors} bind:value={checkedColor} />
          </td>
          <td class="col-3">
            <SvelteSelect items={bgcolors} bind:value={disabledColor} />
          </td>

          <td>
            <Switch
              checkedClass={checkedColor?.value}
              uncheckedClass={uncheckedColor?.value}
              disabledClass={uncheckedColor?.value}
            />
          </td>
        </tr>
        {#each colors as color}
          <tr>
            <td class="col-3">{color.s}</td>

            <td class="col-3">{color.f}</td>
            <td class="col-3">{color.d}</td>
            <td class="col-3">
              <Switch checkedClass={color?.f} uncheckedClass={color?.s}  disabledClass={color?.d}/>
            </td>
          </tr>
        {/each}
      </TableCondensed>
    </ComponentExampleTemplate>
  </svelte:fragment>
</ComponentPageTemplate>

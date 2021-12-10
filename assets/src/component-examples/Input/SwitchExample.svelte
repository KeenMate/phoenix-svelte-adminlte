<script>
  import ComponentPageTemplate from "../../controls/Components/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../controls/Components/ComponentExampleTemplate.svelte";
  import notification from "../../providers/notificationProvider";
  import { Switch, TableCondensed } from "svelte-adminlte";
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
    ],
    events: [
      { name: "change", comment: "", params: "" },
      { name: "checked", comment: "value changed to true", params: "" },
      { name: "unchecked", comment: "value changed to false", params: "" },
    ],
    examples: {
      minimal: {
        name: "usage",
        code: "<Switch bind:checked1 \/>",
      },
      event: {
        name: "Events ",
        code: "<Switch\r\n  bind:checked2\r\n  checkedClass=\"bg-green\"\r\n  on:change={(e) => {\r\n    console.log(\"CHANGED\");\r\n    notify(\"changed\");\r\n  }}\r\n  on:checked={(e) => {\r\n    notify(\"checked\");\r\n  }}\r\n  on:unchecked={(e) => {\r\n    notify(\"unchecked\");\r\n  }}\r\n\/>",
      },
      color: {
        name: "colors",
        code: '<TableCondensed>\r\n<svelte:fragment slot=\"headers\">\r\n  <tr>\r\n    <th>checked<\/th>\r\n    <th>unchecked<\/th>\r\n    <th>switch<\/th>\r\n  <\/tr>\r\n<\/svelte:fragment>\r\n{#each colors as color}\r\n  <tr>\r\n    <td>{color.f}<\/td>\r\n    <td>{color.s}<\/td>\r\n    <td>\r\n      <Switch checkedClass={color.f} \r\n      uncheckedClass={color.s} \/>\r\n\r\n    <\/td>\r\n  <\/tr>\r\n{\/each}\r\n<\/TableCondensed>',
      },
    },
  };
  function notify(text) {
    console.log("NOTIFY");
    notification.success(text);
  }
  let colors =  [
    {f:"bg-primary",s:"bg-secondary"},
    {f:"bg-success",s:"bg-black"},
    {f:"bg-danger",s:"bg-dark"},
    {f:"bg-warning  ",s:"bg-muted"},
    {f:"bg-info",s:"bg-danger"},
  ]
  let checked1,checked2;
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
      <Switch bind:checked1 />
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.event.code}
      name={data.examples.event.name}
    >
<Switch
  bind:checked2
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
      code={data.examples.color.code}
      name={data.examples.color.name}
    >
<TableCondensed>
<svelte:fragment slot="headers">
  <tr>
    <th>checked</th>
    <th>unchecked</th>
    <th>switch</th>
  </tr>
</svelte:fragment>
{#each colors as color}
  <tr>
    <td>{color.f}</td>
    <td>{color.s}</td>
    <td>
      <Switch checkedClass={color.f} 
      uncheckedClass={color.s} />

    </td>
  </tr>
{/each}
</TableCondensed>
    </ComponentExampleTemplate>
  </svelte:fragment>
</ComponentPageTemplate>

<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import { Modal, LteButton } from "@keenmate/svelte-adminlte";
  let data = {
    text: "",
    props: [
      { name: "small", type: "bool", comment: "" },
      { name: "large", type: "bool", comment: "" },
      { name: "xlarge", type: "bool", comment: "" },
      { name: "center", type: "bool", comment: "" },
      { name: "toggle", type: "function", comment: "" },
      { name: "show", type: "function", comment: "" },
      { name: "hide", type: "function", comment: "" },
    ],
    slots: [
      { name: "[default]", comment: "content of modal" },
      { name: "headers", comment: "header" },
      { name: "actions", comment: "bottom part of modal" },
    ],
    examples: {
      minimal: {
        name: "Minimal usage",
        code: "",
      },
      basic: {
        name: "Header and actions ",
        code: "",
      },
    },
  };

  let show, toggle;
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
      <LteButton on:click={show}>show</LteButton>
      <Modal bind:show>HELLO</Modal>
    </ComponentExampleTemplate>

    <ComponentExampleTemplate
      code={data.examples.basic.code}
      name={data.examples.basic.name}
    >
      <LteButton on:click={toggle}>show</LteButton>
      <Modal bind:toggle large>
        HELLO
        <svelte:fragment slot="header">Modal header</svelte:fragment>
        <svelte:fragment slot="actions">
          <LteButton small>action1</LteButton>
          <LteButton small>action2</LteButton>
        </svelte:fragment>
      </Modal>
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

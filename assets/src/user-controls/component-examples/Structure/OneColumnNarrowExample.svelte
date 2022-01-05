<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import { OneColumnNarrow } from "svelte-adminlte";
  import LteButton from "svelte-adminlte/src/ui/LteButton.svelte";
  let data = {
    text: "Div with display flex and gap",
    examples: {
      minimal: {
        name: "usage",
        code: "<OneColumnNarrow>\r\n  <LteButton>Button</LteButton>\r\n  <LteButton>Button</LteButton>\r\n  <LteButton>Button</LteButton>\r\n  <LteButton>Button</LteButton>\r\n</OneColumnNarrow>",
      },
    },
  };
</script>

<ComponentPageTemplate text={data.text}>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.minimal.code}
      name={data.examples.minimal.name}
    >
      <OneColumnNarrow>
        <LteButton>Button</LteButton>
        <LteButton>Button</LteButton>
        <LteButton>Button</LteButton>
        <LteButton>Button</LteButton>
      </OneColumnNarrow>
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

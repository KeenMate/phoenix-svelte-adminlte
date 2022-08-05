<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";

  import { FlexContainer, LteButton } from "@keenmate/svelte-adminlte";

  let data = {
    name: "",
    text: "CSS flex container",
    props: [
      { name: "row", type: "bool", comment: "Default is false." },
      { name: "inline", type: "bool", comment: "Default is false." },
      { name: "justifyContent", type: "string", comment: "" },
      { name: "alignItems", type: "string", comment: "" },
      { name: "wrap", type: "bool", comment: "Default is true." },
    ],
    examples: {
      minimal: {
        name: "minimal",
        code: "<FlexContainer>\r\n  <LteButton>AAAAAAAAAAAAAAA</LteButton>\r\n  <LteButton>BBBBBBBBBBBBBBB</LteButton>\r\n  <LteButton>CCCCCCCCCCCCCCC</LteButton>\r\n  <LteButton>DDDDDDDDDDDDDDD</LteButton>\r\n</FlexContainer>",
      },
      row: {
        name: "row",
        code: "<FlexContainer row>\r\n  <LteButton>AAAAAAAAAAAAAAA</LteButton>\r\n  <LteButton>BBBBBBBBBBBBBBB</LteButton>\r\n  <LteButton>CCCCCCCCCCCCCCC</LteButton>\r\n  <LteButton>DDDDDDDDDDDDDDD</LteButton>\r\n</FlexContainer>",
      },
      inline: {
        name: "inlineflex",
        code: "<FlexContainer inline>\r\n  <LteButton>AAAAAAAAAAAAAAA</LteButton>\r\n  <LteButton>BBBBBBBBBBBBBBB</LteButton>\r\n  <LteButton>CCCCCCCCCCCCCCC</LteButton>\r\n  <LteButton>DDDDDDDDDDDDDDD</LteButton>\r\n</FlexContainer>",
      },
      justifyContent: {
        name: "justify content (around)",
        code: "<FlexContainer justifyContent=\"around\">\r\n  <LteButton>A<\/LteButton>\r\n  <LteButton>B<\/LteButton>\r\n  <LteButton>C<\/LteButton>\r\n  <LteButton>D<\/LteButton>\r\n<\/FlexContainer>",
      },
      alignItems: {
        name: "align Items center",
        code: "<FlexContainer alignItems=\"center\" class=\" h-100\">\r\n  <LteButton>AAAAAAAAAAAAAAA<\/LteButton>\r\n  <LteButton>BBBBBBBBBBBBBBB<\/LteButton>\r\n  <LteButton>CCCCCCCCCCCCCCC<\/LteButton>\r\n  <LteButton>DDDDDDDDDDDDDDD<\/LteButton>\r\n<\/FlexContainer>",
      },
      wrap: {
        name: "no wrap",
        code: "<FlexContainer wrap={false}>\r\n  <LteButton>AAAAAAAAAAAAAAA</LteButton>\r\n  <LteButton>BBBBBBBBBBBBBBB</LteButton>\r\n  <LteButton>CCCCCCCCCCCCCCC</LteButton>\r\n  <LteButton>DDDDDDDDDDDDDDD</LteButton>\r\n</FlexContainer>",
      },
    },
  };
</script>

<ComponentPageTemplate text={data.text} properties={data.props}>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.minimal.code}
      name={data.examples.minimal.name}
    >
      <FlexContainer>
        <LteButton>AAAAAAAAAAAAAAA</LteButton>
        <LteButton>BBBBBBBBBBBBBBB</LteButton>
        <LteButton>CCCCCCCCCCCCCCC</LteButton>
        <LteButton>DDDDDDDDDDDDDDD</LteButton>
      </FlexContainer>
    </ComponentExampleTemplate>

    <ComponentExampleTemplate
      code={data.examples.row.code}
      name={data.examples.row.name}
    >
      <FlexContainer row>
        <LteButton>AAAAAAAAAAAAAAA</LteButton>
        <LteButton>BBBBBBBBBBBBBBB</LteButton>
        <LteButton>CCCCCCCCCCCCCCC</LteButton>
        <LteButton>DDDDDDDDDDDDDDD</LteButton>
      </FlexContainer>
    </ComponentExampleTemplate>

    <ComponentExampleTemplate
      code={data.examples.inline.code}
      name={data.examples.inline.name}
    >
      <FlexContainer inline>
        <LteButton>AAAAAAAAAAAAAAA</LteButton>
        <LteButton>BBBBBBBBBBBBBBB</LteButton>
        <LteButton>CCCCCCCCCCCCCCC</LteButton>
        <LteButton>DDDDDDDDDDDDDDD</LteButton>
      </FlexContainer>
    </ComponentExampleTemplate>

    <ComponentExampleTemplate
    code={data.examples.justifyContent.code}
    name={data.examples.justifyContent.name}
  >
<FlexContainer justifyContent="around">
  <LteButton>A</LteButton>
  <LteButton>B</LteButton>
  <LteButton>C</LteButton>
  <LteButton>D</LteButton>
</FlexContainer>
  </ComponentExampleTemplate>

  <ComponentExampleTemplate
  code={data.examples.alignItems.code}
  name={data.examples.alignItems.name}
>
<FlexContainer alignItems="center" class=" h-100">
  <LteButton>AAAAAAAAAAAAAAA</LteButton>
  <LteButton>BBBBBBBBBBBBBBB</LteButton>
  <LteButton>CCCCCCCCCCCCCCC</LteButton>
  <LteButton>DDDDDDDDDDDDDDD</LteButton>
</FlexContainer>
</ComponentExampleTemplate>

    <ComponentExampleTemplate
      code={data.examples.wrap.code}
      name={data.examples.wrap.name}
    >
      <FlexContainer wrap={false}>
        <LteButton>AAAAAAAAAAAAAAA</LteButton>
        <LteButton>BBBBBBBBBBBBBBB</LteButton>
        <LteButton>CCCCCCCCCCCCCCC</LteButton>
        <LteButton>DDDDDDDDDDDDDDD</LteButton>
      </FlexContainer>
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

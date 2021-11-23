<script>
  import ComponentPageTemplate from "../controls/Components/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../controls/Components/ComponentExampleTemplate.svelte";

  import { Card } from "svelte-adminlte";
import ComponentPageExample from "./ComponentPageExample.svelte";


  let data = {
    name: "Input",
    text: "Component is used for user input. It can be used for multiple types of input",
    props: [
      { name: "color", type: "string | colors from bootstrap", comment: "color of header" },
      { name: "outline", type: "bool", comment: "if true, only top border of card is colored instead of full header" },
      { name: "loading", type: "bool", comment: "if true, show loading symbol instead of content" },
      { name: "noPadding", type: "bool", comment: "if true, disables paddings" },
      { name: "headerClass", type:"string | class", comment:"allows you to direcly add classes to card-header "},
      { name: "class", type:"string | class", comment:"allows you to add classes direcly to card "}
    ],
    examples: {
      minimal: {
        name: "minimal card usage",
        code: '<Card>\r\n<svelte:fragment slot="header"> Title </svelte:fragment>\r\nBody\r\n</Card>',
      },
      colored: {
        name: "card with colored header",
        code: '<Card color="primary">\r\n<svelte:fragment slot="header"> Title </svelte:fragment>\r\nBody Lorem ipsum dolor sit amet, consectetuer adipiscing elit.....\r\n</Card>\r\n',
      },
      colored_outline:{
        name: "card with colored header outline",
        code: '<Card color="danger" outline>\r\n<svelte:fragment slot="header">Title</svelte:fragment>\r\nBody Lorem ipsum dolor sit amet, consectetuer adipiscing elit.....\r\n</Card>'
      }
    },
  };

  let a = "";
</script>

<ComponentPageTemplate
  name={data.name}
  text={data.text}
  properties={data.props}
>
  <svelte:fragment slot="examples">
    <ComponentExampleTemplate
      code={data.examples.minimal.code}
      name={data.examples.minimal.name}
    >
      <Card>
        <svelte:fragment slot="header">Title</svelte:fragment>
        Body Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nam sed tellus
        id magna elementum tincidunt. Mauris elementum mauris vitae tortor. Phasellus
        faucibus molestie nisl. Aliquam id dolor. 
      </Card>
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.colored.code}
      name={data.examples.colored.name}
    >
      <Card color="primary">
        <svelte:fragment slot="header">Title</svelte:fragment>
        Body Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nam sed tellus
        id magna elementum tincidunt. Mauris elementum mauris vitae tortor. Phasellus
        faucibus molestie nisl. Aliquam id dolor. 
      </Card>
      
    </ComponentExampleTemplate>
    <ComponentExampleTemplate
      code={data.examples.colored_outline.code}
      name={data.examples.colored_outline.name}>
      <Card color="danger" outline>
        <svelte:fragment slot="header">Title</svelte:fragment>
        Body Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nam sed tellus
        id magna elementum tincidunt. Mauris elementum mauris vitae tortor. Phasellus
        faucibus molestie nisl. Aliquam id dolor. 
      </Card>
    </ComponentExampleTemplate>
  </svelte:fragment></ComponentPageTemplate
>

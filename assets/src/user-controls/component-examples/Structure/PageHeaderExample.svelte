<script>
  import ComponentPageTemplate from "../../../components/component-templates/ComponentPageTemplate.svelte";
  import ComponentExampleTemplate from "../../../components/component-templates/ComponentExampleTemplate.svelte";


  let data = {
    text: "",
    props: [
      { name: "showBackArrow", type: "bool", comment: "" },
      ],
    events:[
      {name:"backArrowClicked",comment:"only if showBackArrow is true", params:""},
    ],
    examples: {
      minimal: {
        name: "Basic",
        code: "<PageHeader>\r\n  <svelte:fragment>\r\n    Title\r\n  <\/svelte:fragment>\r\n<\/PageHeader>",
      },
      breadcrumb:{
        name:"Breadcrumb",
        code:"<PageHeader>\r\n  <svelte:fragment>\r\n    Title\r\n  <\/svelte:fragment>\r\n  <svelte:fragment slot=\"breadcrumbs\">\r\n    <BreadcrumbItem><a href=\"#\/\">Home<\/a><\/BreadcrumbItem>\r\n    <BreadcrumbItem active>\r\n      PageTitle\r\n    <\/BreadcrumbItem>\r\n  <\/svelte:fragment>\r\n<\/PageHeader>"
      },
      backarrow:{
        name:"BackArrow (showBackArrow true)",
        code:"<PageHeader showBackArrow on:backArrowClicked={handleBackArrowClick}>\r\n  <svelte:fragment slot=\"breadcrumbs\">\r\n    <BreadcrumbItem><a href=\"#\/\">Home<\/a><\/BreadcrumbItem>\r\n    <BreadcrumbItem active>\r\n      PageTitle\r\n    <\/BreadcrumbItem>\r\n  <\/svelte:fragment>\r\n<\/PageHeader>"
      }
      
    },
  };

  
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
      codeonly/>
      <ComponentExampleTemplate
      code={data.examples.breadcrumb.code}
      name={data.examples.breadcrumb.name}
      codeonly/>
      <ComponentExampleTemplate
      code={data.examples.backarrow.code}
      name={data.examples.backarrow.name}
      codeonly/>
    
  </svelte:fragment></ComponentPageTemplate
>

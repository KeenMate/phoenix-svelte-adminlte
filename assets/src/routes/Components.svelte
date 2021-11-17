<script>
  import { _ } from "svelte-i18n";
  import { PageHeader, BreadcrumbItem } from "svelte-adminlte";

</script>

<PageHeader>
    <svelte:fragment>
      {$_("components.title")} <small>Funny Joke</small>
    </svelte:fragment>
  
    <svelte:fragment slot="breadcrumbs">
      <BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
      <BreadcrumbItem active>{$_("components.title")}</BreadcrumbItem>
    </svelte:fragment>
  </PageHeader>
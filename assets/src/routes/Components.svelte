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

  <div class="row mh-100">
      <div class="col-6"></div>
      <div class="col-6">
          <div class="row"></div>
          <div class="row"></div>
      </div>
  </div>
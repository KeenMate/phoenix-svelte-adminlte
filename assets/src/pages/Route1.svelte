<script>
  import { userInfo } from "../stores/authentication";
  import { LteButton, Card, PageHeader,BreadcrumbItem } from "@keenmate/svelte-adminlte";
  import { getConfig, setConfig } from "@keenmate/svelte-adminlte";
  import { _ } from "svelte-i18n";
  import notification from "../providers/notificationProvider";
  import SvelteMarkdown from 'svelte-markdown'


</script>

<PageHeader>
  {$_("home.title")}
  <svelte:fragment slot="breadcrumbs">
    <BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
  </svelte:fragment>
</PageHeader>
<div class="row">
  <div class="col-12">
    <Card outline color="danger">
      <svelte:fragment slot="header"> <SvelteMarkdown source={$_("route1.welcomeHeader")}/> </svelte:fragment>
      <SvelteMarkdown source={$_("route1.welcomeText")}/>
    </Card>
  </div>
</div>
<div class="row">
  <div class="col-lg-3 col-mg-l2">
    <Card outline color="success">
      <svelte:fragment slot="header">Actions</svelte:fragment>
      <div class="row justify-content-start">
        <div class="col-lg-12">
          <LteButton
            on:click={() => {
              setConfig({ Foo: "Henlo" });
            }}
          >
            Set config
          </LteButton>
        </div>
        <div class=" col-lg-12">
          <LteButton
            on:click={() => {
              let arr = null;
              console.log(arr.abc);
            }}
          >
            Throw
          </LteButton>
        </div>
        <div class=" col-lg-12">
          <LteButton
            on:click={() =>
              notification.success(
                " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sit amet maximus ex, et lacinia est. Nullam sed orci lectus. Vivamus id arcu mauris. Ut posuere aliquam ex vel elementum. Nam aliquet non nisi sed consectetur. Quisque varius ut magna nec iaculis. Cras volutpat augue pharetra ultricies hendrerit. Ut laoreet convallis dui. Proin dapibus iaculis turpis, in posuere nulla pulvinar id. ",
                "Notification title"
              )}
          >
            Notify me
          </LteButton>
        </div>
      </div>
    </Card>
  </div>
  <div class="col-lg-9 col-mg-l2">
    <Card outline color="info">
      <svelte:fragment slot="header">User Info</svelte:fragment>
      {#if $userInfo != {}}
        <pre> {JSON.stringify($userInfo, null, 2)}</pre>
      {:else}
        <b>You have to be logged in to see user info</b>
      {/if}
    </Card>
  </div>
</div>

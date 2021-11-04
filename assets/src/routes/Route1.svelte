<script>
  import {userInfo} from "../stores/authentication";
  import { LteButton, Card,PageHeader } from "svelte-adminlte";
  import { getConfig, setConfig } from "svelte-adminlte";

  import notification from "../providers/notificationProvider";

<PageHeader>
  Home
</PageHeader>
<div class="row">
  <div class="col-3">
<Card outline color="danger" >
  <svelte:fragment slot="header">Actions  </svelte:fragment>
  <LteButton
  on:click={() => {
    setConfig({ Foo: "Henlo" });
  }}>
  Set config
</LteButton>

<LteButton
  on:click={() => {
    let arr = null;

    console.log(arr.abc);
  }}
>
  Throw
</LteButton>

<LteButton
  on:click={() =>
    notification.success(
      " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sit amet maximus ex, et lacinia est. Nullam sed orci lectus. Vivamus id arcu mauris. Ut posuere aliquam ex vel elementum. Nam aliquet non nisi sed consectetur. Quisque varius ut magna nec iaculis. Cras volutpat augue pharetra ultricies hendrerit. Ut laoreet convallis dui. Proin dapibus iaculis turpis, in posuere nulla pulvinar id. ",
      "Notification title"
    )}
>
  Notify me
</LteButton>
</Card>
</div>
<div class="col-9">
  <Card outline color="danger" >
  <svelte:fragment slot="header">User Info</svelte:fragment>
  {#if $userInfo != {}}
    

  <pre> {JSON.stringify($userInfo, null, 2)}</pre>
    {:else}
    <b>You have to be logged in to see user info</b>
  {/if}
</Card>
</div>
</div>
<script>
    export let href = "#";
    export let icon;
  </script>
  
  <li class="nav-item">
    <a {href} class="nav-link">
      {#if icon}
        <i class="nav-icon {icon}" />
      {/if}
  
      <slot/>
    </a>
    <ul class="nav nav-treeview">
        <slot name="children"></slot>
    </ul>
  </li>
  
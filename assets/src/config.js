
import { getConfig, setConfig } from "@keenmate/svelte-adminlte/config"

const custom = {
  ContactEmail: "example@keenmate.com"
};


export function getCustomConfig() {
  setConfig(custom);
  return getConfig();
}
import { writable } from "svelte/store";

export const clientId = writable("");
export const issuer = writable("");

export function setProvider(newIssuer, newClientId) {
  issuer.set(newIssuer);
  clientId.set(newClientId)
}

// TODO remove
export const setAzureProvider = () => setProvider("https://login.microsoftonline.com/6ee623a2-0b05-4ea4-b931-79c555955cb1/v2.0/", "f1b31a4f-f065-4b87-a9a9-eb802130c87d");
export const setZuubrProvider = () => setProvider("https://auth.zuubr.com/auth/realms/zuubr", "phoenix-svelte-adminlte-local");
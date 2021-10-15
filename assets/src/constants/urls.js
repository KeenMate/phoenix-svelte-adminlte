// export const ApiUrl = process.env.SERVER_URL

export const AppUrl = process.env.MIX_ENV === "prod" ? "https://phoenix-svelte-adminlte.demo.keenmate.com" : "http://localhost:4000";
export const SocketPath = "/socket"

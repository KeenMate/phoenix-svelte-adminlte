import "admin-lte/build/scss/adminlte.scss";
import "toastr/build/toastr.css";

import "bootstrap/dist/js/bootstrap.bundle";
import "admin-lte/dist/js/adminlte";

import App from "./App.svelte"
import Error from "./Error.svelte"


import {getCustomConfig} from "./config"

// import "./assets/overrides.css"
// import "./assets/loader.css"
// import "./assets/select2-overrides.css"
// import "./assets/fonts.css"

let target = document.getElementById("app")

const app = new App({ target })

window.addEventListener("error", (event) => {
	console.log(event)

	app.$destroy();
	target.innerHTML = '';
	window.location = "#/error";

	let config = getCustomConfig()

	new Error({ target, props: { code: 502, message: "Hello" ,email: config.ContactEmail }  })

	window.dispatchEvent(new Event("resize"));
});

export default app

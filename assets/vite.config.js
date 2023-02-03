import { defineConfig } from "vite";
import { svelte } from "@sveltejs/vite-plugin-svelte";
import sveltePreprocess from "svelte-preprocess";

const isProduction = process.env.NODE_ENV === "production";
console.log("IS PRODUCTION BUILD: ", isProduction);
// for prod build top dist so you can copy in pipeline
const outRootDir = isProduction ? "dist" : "../priv/static";
// https://vitejs.dev/config/
export default defineConfig({
	build: {
		target: "es2015",
	},
	plugins: [svelte({ preprocess: sveltePreprocess() })],
	resolve: {
		alias: {
			"~bootstrap": "bootstrap",
		},
	},
	optimizeDeps: {
		include: [
			"toastr",
			"inputmask",
			"jquery",
			"highlight.js",
			"highlight.js/lib/core",
		],
	},
	build: {
		// assetsDir: "",
		outDir: outRootDir,
		minify: isProduction,
		sourcemap: !isProduction,
	},
});

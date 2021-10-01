import svelte from "rollup-plugin-svelte"
import commonjs from "@rollup/plugin-commonjs"
import resolve from "@rollup/plugin-node-resolve"
import replace from "@rollup/plugin-replace"
import esbuild from "rollup-plugin-esbuild"
import postcss from "rollup-plugin-postcss";
import copy from "rollup-plugin-copy"
import sveltePreprocess from "svelte-preprocess";
import dotenv from "rollup-plugin-dotenv";

const production = process.env.MIX_ENV === "prod";

export default {
	input: "src/main.js",
	output: {
		sourcemap: !production,
		format: "iife",
		name: "app",
		// dir: "public",
		file: "../priv/static/app.js",
		globals: {
			"jquery": "jQuery",
		}
	},
	external: [
		"jquery",
	],
	plugins: [
		dotenv(),
		// replace({
		// 	values: {}
		// }),
		svelte({
			compilerOptions: {
				// enable run-time checks when not in production
				dev: !production
			},
			preprocess: sveltePreprocess({
				// emitCss: true
				postcss: true
			}),
			onwarn() { }
		}),
		postcss({
			extract: true
		}),

		resolve({
			browser: true,
			dedupe: ['svelte']
		}),

		commonjs(),

		esbuild({
			minify: production,
			target: 'es2015'
		}),

		copy({
			targets: [
				{ src: "static/*", dest: "../priv/static"}
				// {src: "src/assets/*", dest: "public"}
				// { src: "public/admin-app/index.html", dest: "./public" }
			]
		}),
	],
	watch: {
		clearScreen: true
	}
}

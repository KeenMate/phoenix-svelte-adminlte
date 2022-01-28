import svelte from "rollup-plugin-svelte"
import commonjs from "@rollup/plugin-commonjs"
import resolve from "@rollup/plugin-node-resolve"
import replace from "@rollup/plugin-replace"
import esbuild from "rollup-plugin-esbuild"
import postcss from "rollup-plugin-postcss";
import copy from "rollup-plugin-copy"
import sveltePreprocess from "svelte-preprocess";
import dotenv from "rollup-plugin-dotenv";
import json from '@rollup/plugin-json';
import analyze from 'rollup-plugin-analyzer'
import { visualizer } from 'rollup-plugin-visualizer';
import { terser } from 'rollup-plugin-terser';

const production = process.env.MIX_ENV === "prod";
const devBranch = process.env.DRONE_COMMIT_BRANCH === "dev";
const url = devBranch ? '"https://dev.phoenix-svelte-adminlte.demo.keenmate.com"' :'"https://phoenix-svelte-adminlte.demo.keenmate.com"';
export default {
	input: "src/main.js",
	output: {
		sourcemap: !production,
		format: "esm",
		name: "app",
		dir: "../priv/static/",
		plugins:[terser()]
	},
	plugins: [
		replace({
			values: {
				"process.env.APP_URL": production ? url : '"http://localhost:4000"'
			}
		}),
		json(),
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
		postcss(
			{ extract: true, minimize: true }
		),

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
				{ src: "static/*", dest: "../priv/static" },
				{ src: "node_modules/jsoneditor/dist/img/jsoneditor-icons.svg", dest: "../priv/static/img" },
				// {src: "src/assets/*", dest: "public"}
				// { src: "public/admin-app/index.html", dest: "./public" }
			]
		}),
		analyze({summaryOnly: true,limit: 10}),
		visualizer(),
		terser()
	],
	watch: {
		clearScreen: true
	}
}

import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'
import sveltePreprocess from 'svelte-preprocess';

// https://vitejs.dev/config/
export default defineConfig({
	build: {
		target: 'es2015'
	},
	plugins: [
		svelte({ preprocess: sveltePreprocess() }),
	],
	resolve: {
		alias: {
			'~bootstrap': 'bootstrap'
		}
	},
	optimizeDeps: {
		include: [
			'toastr',
			'inputmask',
			'jquery',
			'highlight.js', 
			'highlight.js/lib/core',
		]
	}
})

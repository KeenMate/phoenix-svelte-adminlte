<script>
	import { onMount } from "svelte";

	export let src = "";
	export let alt = "";
	export let title = "";
	export let isSelected = false;
	export let isThumbnailed = false;
	export let isRounded = false;
	export let hasShadow = false;

	$: classes = imageContainerClasses();

	$: isSelected,
		isThumbnailed,
		isRounded,
		hasShadow,
		(classes = imageContainerClasses());

	function imageContainerClasses() {
		const classes = ["img-container"];

		isSelected && classes.push("selected");
		isThumbnailed && classes.push("thumbnail");
		isRounded && classes.push("rounded");
		hasShadow && classes.push("drop-shadow");

		return classes.join(" ");
	}

	onMount(() => {
		imageContainerClasses();
	});
</script>

<div class={classes} on:click>
	<img {alt} {src} style="width: 100%; display: block;" />
	{#if title}
		<span class="title">
			{title}
		</span>
	{/if}
	<div class="or2Zo" tabindex="0">
		<svg width="24px" height="24px" class="rqet2b" viewBox="0 0 24 24"
			><path
				d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"
			/></svg
		>
		<svg width="24px" height="24px" class="eoYPIb" viewBox="0 0 24 24"
			><circle cx="12.5" cy="12.2" r="8.292" /></svg
		>
		<svg width="24px" height="24px" class="aiEkg" viewBox="0 0 24 24"
			><circle
				opacity=".26"
				fill="url(#checkboxShadowCircle)"
				cx="12"
				cy="13.512"
				r="10.488"
			/><circle class="zlMbnc" cx="12" cy="12.2" r="8.292" /></svg
		>
		<svg width="24px" height="24px" class="orgUxc" viewBox="0 0 24 24"
			><path
				d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"
			/></svg
		>
	</div>
	<div class="eGiHwc" />
</div>

<style lang="scss">
	.or2Zo {
		box-sizing: border-box;
		color: transparent;
		fill: transparent;
		outline: none;
		padding: 8px 24px 24px 8px;
		cursor: pointer;
		display: inline-block;
		height: 24px;
		outline: none;
		position: absolute;
		user-select: none;
		width: 24px;
		top: 0;
		left: 0;
		z-index: 1;
	}

	.rqet2b {
		display: none;
		fill-opacity: 0.54;
		position: absolute;
	}

	.eoYPIb {
		display: none;
		fill: transparent;
		position: absolute;
	}

	.aiEkg {
		display: none;
		position: absolute;
	}

	.orgUxc {
		fill: transparent;
		transition: all 0.135s cubic-bezier(0, 0, 0.2, 1);
		transition-property: opacity, fill-opacity;
		fill-opacity: 0.54;
		position: absolute;
	}

	.eGiHwc {
		background-image: linear-gradient(
			180deg,
			rgba(0, 0, 0, 0.26),
			transparent 56px,
			transparent
		);
		height: 100%;
		opacity: 0;
		position: absolute;
		top: 0;
		left: 0;
		transition: opacity 0.135s cubic-bezier(0, 0, 0.2, 1);
		width: 100%;
	}

	.img-container,
	.img-fluid,
	.img-thumbnail {
		width: 100%;
		max-width: 100%;
		height: auto;
		display: block;
		position: relative;
		vertical-align: middle;
		background-color: transparent;
		-webkit-transition: all 0.3s ease-in-out;
		-o-transition: all 0.3s ease-in-out;
		transition: all 0.3s ease-in-out;
		overflow: visible;
	}
	.img-thumbnail {
		padding: 0.25rem;
		border: 1px solid #dfdfdf;
		border-radius: 0.25rem;
		background-color: #ffffff;
	}
	.img-container {
		display: block;
		background-color: #e8f0fe;
		user-select: none;

		&:not(.selected):hover {
			.or2Zo {
				color: #fff;
				fill: #fff;
			}

			.eoYPIb {
				fill: #fff;
			}

			.orgUxc {
				fill: currentColor;
			}

			.eGiHwc {
				opacity: 1;
			}
		}
	}
	.img-container img {
		width: 100%;
		max-width: 100%;
		height: auto;
		position: relative;
	}
	.img-container .image-overlay {
		position: absolute;
		top: 0;
		bottom: 0;
		left: 0;
		right: 0;
		opacity: 0;
		overflow: hidden;
		font-size: 0.875rem;
		line-height: 1rem;
		padding: 2em;
		background-color: rgba(27, 161, 226, 0.7);
		color: #ffffff;
		text-align: center;
		border-radius: inherit;
		-webkit-transition: all 0.3s ease-in-out;
		-o-transition: all 0.3s ease-in-out;
		transition: all 0.3s ease-in-out;
	}
	.img-container .image-overlay * {
		color: #ffffff;
	}
	.img-container .image-overlay:hover {
		opacity: 1;
	}
	.img-container .image-overlay:hover:before,
	.img-container .image-overlay:hover:after {
		opacity: 1;
		-webkit-transform: scale(1);
		-ms-transform: scale(1);
		transform: scale(1);
	}
	.img-container .image-overlay:before,
	.img-container .image-overlay:after {
		display: block;
		position: absolute;
		content: "";
		border: 1px solid rgba(255, 255, 255, 0.7);
		top: 1em;
		bottom: 1em;
		left: 1em;
		right: 1em;
		opacity: 0;
		border-radius: inherit;
		-webkit-transform: scale(1.5);
		-ms-transform: scale(1.5);
		transform: scale(1.5);
		-webkit-transition: all 0.3s ease-in-out;
		-o-transition: all 0.3s ease-in-out;
		transition: all 0.3s ease-in-out;
	}
	.img-container .image-overlay:after {
		border-left: none;
		border-right: none;
		bottom: 1em;
		top: 1em;
	}
	.img-container .image-overlay:before {
		border-top: none;
		border-bottom: none;
		bottom: 1em;
		top: 1em;
	}
	.img-container.rounded img {
		border-radius: 0.25rem;
	}
	.img-container.thumbnail {
		padding: 0.25rem;
		border: 1px solid #dfdfdf;
		background-color: #ffffff;
	}
	.img-container.thumbnail .title {
		font-size: 0.9rem;
		line-height: 1;
	}
	.img-container img + .title {
		margin-top: 0.25rem;
	}
	.img-container .title + img {
		margin-top: 0.25rem;
	}
	.img-container.cover {
		background-size: cover;
		background: no-repeat 100% 100%;
	}
	figure {
		margin: 0 0 1rem;
	}
	figure img {
		width: 100%;
		max-width: 100%;
		height: auto;
		display: block;
		position: relative;
		vertical-align: middle;
		background-color: transparent;
		-webkit-transition: all 0.3s ease-in-out;
		-o-transition: all 0.3s ease-in-out;
		transition: all 0.3s ease-in-out;
	}

	.selected {
		img {
			transform: scale(0.9);
		}

		.rqet2b {
			display: block;
			fill: currentColor;
		}

		.eoYPIb {
			display: block;
		}

		.aiEkg {
			display: block;
			fill: #fff;
		}

		.orgUxc {
			fill: #1a73e8;
			fill-opacity: 1;
		}

		.eGiHwc {
			opacity: 0;
		}
	}
	.selected::before {
		background-color: transparent;
		border-color: #ffffff !important;
		border-left: 2px solid;
		border-bottom: 2px solid;
		position: absolute;
		display: block;
		content: "";
		z-index: 102;
		-webkit-transform: rotate(-45deg);
		height: 0.325rem;
		width: 0.5rem;
		top: 0.25rem;
		right: 0.25rem;
		-ms-transform: rotate(-45deg);
		transform: rotate(-45deg);
	}

	.drop-shadow {
		-webkit-box-shadow: 2px 2px 5px 0 rgba(0, 0, 0, 0.4);
		box-shadow: 2px 2px 5px 0 rgba(0, 0, 0, 0.4);
	}
	.rounded {
		border-radius: 0.25rem !important;
	}
</style>

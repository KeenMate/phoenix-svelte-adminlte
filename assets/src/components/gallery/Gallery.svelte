<script>
	export let images = [];
	export let imageSize = "150px";
	export let imagesPerRow = null;
	let container;
	let innerWidth;
	$: innerWidth,
		(imageSize = resizeImages(imagesPerRow, container?.clientWidth));
	function resizeImages(count, width) {
		if (!count || !width) return imageSize;
		let size = (width - 5 * count) / count;
		return size + "px";
	}

	//
</script>

<svelte:window bind:innerWidth />
<div class="gallery" bind:this={container}>
	{#each images as image (image.id)}
		<div class="gallery__item" style={"width: " + imageSize}>
			<slot name="image" {image}>
				<a href={image.src} data-toggle="lightbox" data-title={image.title}>
					<img src={image.msrc} class="img-fluid" alt={image.title} />
				</a>
			</slot>
		</div>
	{/each}
</div>

<style lang="scss">
	.gallery {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		grid-gap: 5px;

		&__item {
			&:hover {
				cursor: pointer;
			}
		}
	}
</style>

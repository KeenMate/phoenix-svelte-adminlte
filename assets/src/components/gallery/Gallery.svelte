<script>
	export let images = [];
	export let imageSize = "150px";
</script>

<div class="gallery">
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
		grid-gap: 0.5rem;

		&__item {
			&:hover {
				cursor: pointer;
			}
		}
	}
</style>

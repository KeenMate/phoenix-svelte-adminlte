<script>
	export let images = [];
</script>

<div class="gallery">
	{#each images as image (image.id)}
		<div class="gallery__item">
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
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
		grid-gap: 0.5rem;

		&__item {
			&:hover {
				cursor: pointer;
			}
		}
	}
</style>

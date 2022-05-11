<script>
	import { onMount } from "svelte";
	import { _ } from "svelte-i18n";
	import PhotosProvider from "../providers/photos";
	import FilePond, { registerPlugin, supported } from "svelte-filepond";
	import { Socket as PhoenixSocket } from "phoenix";
	import { SocketPath } from "../constants/urls";
	// import cs_CZ from 'filepond/locale/cs-cz'
	import FilePondPluginImageExifOrientation from "filepond-plugin-image-exif-orientation";
	import FilePondPluginImagePreview from "filepond-plugin-image-preview";
	import {
		Toastr,
		PageHeader,
		Card,
		Callout,
		LteButton,
		BreadcrumbItem,
	} from "svelte-adminlte";
	import WithLazyLoader from "../components/WithLazyLoader.svelte";
	import Image from "../components/gallery/Image.svelte";
	import Gallery from "../components/gallery/Gallery.svelte";
	import selectMany from "../helpers/select-many-helper";
	import { Fancybox } from "@fancyapps/ui";

	import "filepond/dist/filepond.css";
	import "filepond-plugin-image-preview/dist/filepond-plugin-image-preview.css";
	import "@fancyapps/ui/dist/fancybox.css";

	registerPlugin(
		FilePondPluginImageExifOrientation,
		FilePondPluginImagePreview
	);

	let photosTask = [];
	let photos = [];
	let selectedImageIds = [];
	let toBeDeletedImage = null;
	let lastImageIndexClicked = null;
	let uploadedImages = [];

	$: loadPhotos();

	// a reference to the component, used to call FilePond methods
	let pond = {
		process(
			fieldName,
			file,
			metadata,
			load,
			error,
			progress,
			abort,
			transfer,
			options
		) {
			const formData = new FormData();
			formData.append(fieldName, file, file.name);

			const request = new XMLHttpRequest();
			request.open("POST", PhotosProvider.getProcessUrl());

			request.upload.onprogress = (e) => {
				progress(e.lengthComputable, e.loaded, e.total);
			};

			request.onload = function () {
				if (request.status >= 200 && request.status < 300)
					load(request.responseText);
				else error("oh no");
			};

			request.send(formData);

			return {
				abort() {
					request.abort();
					abort();
				},
			};
		},
		fetch: null,
		revert: null,
		load: null,
		patch: null,
		restore: null,
	};

	// pond.getFiles() will return the active files

	// the name to use for the internal file input
	let name = "filepond";

	// handle filepond events
	function handleInit() {
		console.log("FilePond has initialised");
	}

	function handleAddFile(err, fileItem) {
		console.log("A file has been added", fileItem);
	}

	function loadPhotos() {
		photosTask = PhotosProvider.getImages()
			.then((x) => {
				photos = x;
			})
			.catch((error) => {
				console.error("Could not load images", error);
				Toastr.error("Could not load images");
			});
	}

	function onImageClick(image) {
		lastImageIndexClicked = photos.indexOf(image);

		//toggle image selection
		if (selectedImageIds.includes(image.id)) {
			selectedImageIds = selectedImageIds.filter((x) => x !== image.id);
		} else {
			selectedImageIds = [image.id, ...selectedImageIds];
		}
	}

	function onImageClickWithShift(image) {
		if (lastImageIndexClicked === null) return;

		selectedImageIds = selectMany(
			photos,
			"id",
			lastImageIndexClicked,
			photos.indexOf(image),
			(selectedImageIds.includes(photos[lastImageIndexClicked].id) &&
				"select") ||
				"deselect",
			selectedImageIds
		);
		console.log(selectedImageIds);
	}

	//if selected image is set it will be deleted instead of selected images
	function onBeforeDeleteSelected(selectedImage) {
		if (selectedImage) {
			toBeDeletedImage = selectedImage;
		}

		deleteSelectedImages();
	}

	async function deleteSelectedImages() {
		try {
			let deleteTasks;

			if (selectedImageIds.length) {
				deleteTasks = selectedImageIds
					.map((id) => photos.find((img) => img.id === id))
					.filter((x) => x)
					.map((x) => deleteImage(x, true));
			} else {
				deleteTasks = [deleteImage(toBeDeletedImage, true)];
			}

			await Promise.all(deleteTasks);

			Toastr.success(
				$_("deletedPhotos", { values: { n: deleteTasks.length } })
			);
		} catch (error) {
			Toastr.error($_("photos.deletePhotosError"));
		}
	}

	async function deleteImage(image, noToast, toggleModal) {
		console.log(image);
		const task = PhotosProvider.deleteImage(image.uuid);

		task.then((_x) => {
			photos = photos.filter((x) => x !== image);
			selectedImageIds = selectedImageIds.filter((x) => x !== image.id);
		});

		if (noToast) return task;

		task.then((_x) => {
			Toastr.success(
				$_("deletedPhotos", { values: { n: selectedImageIds.length } })
			);
		});

		return task;
	}

	function createWebsocket() {
		let files = [];
		const openWebSocketUpload = (path) => {
			const socket = new PhoenixSocket(path, { params: {} });
			socket.connect();

			let processedFiles = [];
			const channel = socket.channel("photo:upload", { files });

			channel.on("image_processed", (msg) => {
				console.log("image processed");
				console.log(msg);
				if (msg.status === "ok" && !processedFiles.includes(msg.filename)) {
					processedFiles.push(msg.filename);
					Toastr.success(`Fotka ${msg.filename} byla úspěšně zpracována`);

					if (processedFiles.length === files.length) {
						processedFiles = [];
						files = [];
					}
				} else if (msg.status instanceof Array) {
					const [status, reason] = msg.status;
					if (status === "error") {
						Toastr.error(`Fotku ${msg.filename} se nepodařilo zpracovat.`);
						console.error(
							`Could not process image: ${msg.filename}, reason: ${reason}`
						);
					}
				} else {
					Toastr.warning(
						`Nelze rozpoznat stav fotky: ${msg.filename} (Více v consoli)`
					);
					console.warn(
						`Unknown image processed (${msg.filename}) status: `,
						msg.status
					);
				}
			});

			channel.on("phx_leave", () => {
				channel.leave();
				Toastr.info("Zpracování fotek bylo dokončeno");

				loadPhotos();
			});

			channel
				.join()
				.receive("ok", () => console.log("catching up", arguments))
				.receive("error", () => console.warn("failed join", arguments))
				.receive("timeout", () =>
					console.warn("Networking issue. Still waiting...")
				);

			return {
				socket,
				channel,
			};
		};

		let socket;
		let channel;

		let websocketTimeout = null;
		const websocketDebounce = function () {
			clearTimeout(websocketTimeout);
			websocketTimeout = setTimeout(function () {
				const websocket = openWebSocketUpload(SocketPath, [...files]);
				socket = websocket.socket;
				channel = websocket.channel;
			}, 500);
		};

		const pond = document.querySelector(".filepond--root");
		pond.addEventListener("FilePond:addfile", (arg) => {
			const { filename } = arg.detail.file;

			websocketDebounce();
			if (uploadedImages.includes(filename)) return;

			uploadedImages = [...uploadedImages, filename];
			files = [...files, filename];
		});
	}

	onMount(() => {
		loadPhotos();

		createWebsocket();
	});
</script>

<PageHeader>
	<svelte:fragment>
		{$_("photos.title")}
	</svelte:fragment>

	<svelte:fragment slot="breadcrumbs">
		<BreadcrumbItem><a href="#/">{$_("home.title")}</a></BreadcrumbItem>
		<BreadcrumbItem active>
			{$_("photos.title")}
		</BreadcrumbItem>
	</svelte:fragment>
</PageHeader>

<div class="row">
	<div class="col-lg-3">
		<Card>
			<svelte:fragment slot="header">
				<i class="fas fa-upload" />
				{$_("photos.upload")}
			</svelte:fragment>
			<FilePond
				{name}
				server={pond}
				allowMultiple={true}
				oninit={handleInit}
				onaddfile={handleAddFile}
			/>
		</Card>
	</div>
	<div class="col-lg-9">
		<Card>
			<svelte:fragment slot="header">
				<i class="fas fa-camera" />
				{$_("photos.title")}
			</svelte:fragment>
			<svelte:fragment slot="tools">
				{#if selectedImageIds.length}
					<LteButton
						small
						color="secondary"
						on:click={() => (selectedImageIds = [])}
						>{$_("photos.cancelSelection")}</LteButton
					>
					<LteButton
						small
						color="danger"
						on:click={() => onBeforeDeleteSelected()}
						>{$_("photos.deleteSelected")} ({selectedImageIds.length})</LteButton
					>
				{/if}
			</svelte:fragment>
			<WithLazyLoader task={photosTask}>
				{#if photos?.length}
					<Gallery images={photos}>
						<svelte:fragment slot="image" let:image>
							<div class="photo">
								<figure>
									<Image
										isSelected={selectedImageIds.includes(image.id)}
										on:click={(e) => !e.shiftKey && onImageClick(image)}
										on:click={(e) => e.shiftKey && onImageClickWithShift(image)}
										src={image.thumbnailUrl}
									/>
								</figure>
								<div class="options">
									<LteButton
										xsmall
										data-fancybox="photos"
										href={image.originalUrl}
										data-thumb={image.thumbnailUrl}
										title={$_("photos.preview")}
									>
										<i class="far fa-eye" />
									</LteButton>
									<LteButton
										xsmall
										on:click={onBeforeDeleteSelected(image)}
										title={$_("common.buttons.delete")}
									>
										<i class="fas fa-trash" />
									</LteButton>
								</div>
							</div>
						</svelte:fragment>
					</Gallery>
				{:else}
					<Callout color="warning">
						{$_("commen.error.noDataToShow")}
					</Callout>
				{/if}

				<svelte:fragment slot="catch">
					<Callout>Error occured while loading data</Callout>
				</svelte:fragment>
			</WithLazyLoader>
		</Card>
	</div>
</div>

<style global lang="scss">
	.images-gallery {
		.row {
			margin-bottom: 0.8rem;
		}
	}

	.photo {
		position: relative;
		padding-bottom: 2em;

		figure {
			position: relative;
			display: block;
			margin: 0;
			padding-bottom: 100%;

			.img-container {
				width: 100%;
				height: 100%;

				bottom: 0;
				left: 0;
				position: absolute !important;
				right: 0;
				top: 0;

				&.selected {
					height: calc(100% + 1.7rem);
				}

				img {
					display: flex;
					justify-content: space-around;
					font-weight: 300;
					line-height: 2;
					text-align: center;

					width: 100%;
					height: auto;
					position: relative;
					transition: all 0.3s ease-in-out;

					&:before {
						$icon-size: 2rem;

						content: "\f1c5";
						font-size: $icon-size;
						font-family: "Font Awesome 5 Free";
						color: rgb(100, 100, 100);
						display: block;
						width: 100%;
						height: 100%;
						position: absolute;
						background-color: #e1e0e0;
						padding-top: calc(50% - #{$icon-size});
					}
				}
			}
		}

		.options {
			position: absolute;
			display: flex;
			align-items: center;
			bottom: 0.1rem;
			width: 100%;
			background-color: white;

			& > * {
				flex: 1;
				border: 1px solid gray;
				border-top-left-radius: 0;
				border-top-right-radius: 0;

				&:first-child {
					border-bottom-right-radius: 0;
				}

				&:last-child {
					border-bottom-left-radius: 0;
				}
			}
		}
	}
</style>

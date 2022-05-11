import BaseProvider from "./baseProvider";
import { GET, POST, PUT, PATCH, DELETE } from "../constants/methods";
import { AppUrl, PhotosEndpoints } from "../constants/urls";
import { parseUser } from "./parser";

import testPhotos from "../test-data/testPhotos.json";

export class GalleryImage {
	/**
	 * ID of gallery image
	 * @type {number}
	 */
	galleryPhotoId;

	/**
	 * ID of Image
	 * @type {number}
	 */
	id;

	/**
	 * UUID of Image
	 * @type {string}
	 */
	uuid;

	/**
	 * X dimension of Image
	 * @type {number}
	 */
	width;

	/**
	 * Y dimension of Image
	 * @type {number}
	 */
	height;

	/**
	 * File size of Image in bytes
	 * @type {number}
	 */
	size;

	/**
	 * Url pointing to thumbnailed version of image
	 * @type {string}
	 */
	thumbnailUrl;

	/**
	 * Url pointing to full-sized image
	 * @type {string}
	 */
	originalUrl;

	constructor(
		galleryPhotoId,
		id,
		uuid,
		originalUrl,
		thumbnailUrl,
		size,
		width,
		height
	) {
		this.galleryPhotoId = galleryPhotoId;
		this.id = id;
		this.uuid = uuid;
		this.originalUrl = originalUrl;
		this.thumbnailUrl = thumbnailUrl;
		this.size = size;
		this.width = width;
		this.height = height;
	}
}

export class PhotosProvider extends BaseProvider {
	getProcessUrl() {
		return PhotosEndpoints.process;
	}

	async getImages() {
		const response =
			(await this.fetchResource(GET, PhotosEndpoints.listPhotos)) || [];

		if (!(response instanceof Array) && response.error) {
			console.error("Error during loading images: ", response.message);
			throw new Error(response.message);
		}
		console.log(response);

		return response.data.map(
			(x) =>

				new GalleryImage(
					null,
					x.id,
					x.uuid,
					x.original_url,
					x.thumbnail_url,
					x.size,
					x.width,
					x.height
				)
		);

		// return testPhotos.map(
		// 	(p) =>
		// 		new GalleryImage(
		// 			null,
		// 			p.id,
		// 			p.uuid,
		// 			p.original_url,
		// 			p.thumbnail_url,
		// 			p.size,
		// 			p.width,
		// 			p.height
		// 		)
		// );
	}

	async deleteImage(uuid) {
		return this.fetchResource(
			DELETE,
			PhotosEndpoints.deletePhoto(uuid),
			null,
			null,
			false
		);
	}
}

export default new PhotosProvider();

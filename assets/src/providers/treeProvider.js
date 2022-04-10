import BaseProvider from "./baseProvider"

export class UrlProvider extends BaseProvider {

	async getTree() {
		const response = await this.fetchResource("GET", "/data/tree")

		return response
	}
}

export default new UrlProvider()
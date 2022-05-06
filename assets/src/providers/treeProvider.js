import BaseProvider from "./baseProvider";
import { GET } from "../constants/methods";
import { BaseTreeDataPath } from "../constants/urls";

export class UrlProvider extends BaseProvider {
	async getTree() {
		const response = await this.fetchResource(GET, BaseTreeDataPath);

		return response;
	}
}

export default new UrlProvider();

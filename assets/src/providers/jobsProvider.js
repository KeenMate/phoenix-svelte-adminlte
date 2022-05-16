import BaseProvider from "./baseProvider";
import { DELETE, GET } from "../constants/methods";
import { JobsEndpoints } from "../constants/urls";

export class JobsProvider extends BaseProvider {
	async getJobs() {
		const response = await this.fetchResource(GET, JobsEndpoints.getJobs);
		return response;
	}
	async deleteJob(id) {
		const response = await this.fetchResource(
			DELETE,
			JobsEndpoints.deleteJob(id)
		);
		return response;
	}
}

export default new JobsProvider();

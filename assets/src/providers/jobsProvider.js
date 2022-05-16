import BaseProvider from "./baseProvider";
import { DELETE, GET, POST } from "../constants/methods";
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
	async addJob(name, cron, script) {
		const response = await this.fetchResource(POST, JobsEndpoints.addJob, {
			name: name,
			cron: cron,
			script: script,
		});
		return response;
	}
}

export default new JobsProvider();

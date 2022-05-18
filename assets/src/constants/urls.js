// export const ApiUrl = process.env.SERVER_URL

export const AppUrl = process.env.APP_URL;
export const SocketPath = "/socket";

export const BaseApiPath = AppUrl + "/api";
export const PhotosApiPath = BaseApiPath + "/image";
export const JobsApiPath = BaseApiPath + "/jobs";

export const BaseDataPath = AppUrl + "/data";
export const BaseTreeDataPath = BaseDataPath + "/tree";

export const PhotosEndpoints = {
	listPhotos: `${PhotosApiPath}`,
	deletePhoto: (uuid) => `${PhotosApiPath}/${uuid}`,
	process: `${PhotosApiPath}/process`,
};
export const JobsEndpoints = {
	getJobs: `${JobsApiPath}`,
	getScript: (id) => `${JobsApiPath}/script/${id}`,
	deleteJob: (id) => `${JobsApiPath}/${id}`,
	addJob: `${JobsApiPath}`,
	getJobRuns: `${JobsApiPath}/job_runs`,
	getJob: `${JobsApiPath}/job`,
};

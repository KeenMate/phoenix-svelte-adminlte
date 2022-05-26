// export const ApiUrl = process.env.SERVER_URL

export const AppUrl = process.env.APP_URL;
export const AppLoginUrl = AppUrl + "/auth"
export const SocketPath = "/socket";

export const BaseApiPath = AppUrl + "/api";
export const PhotosApiPath = BaseApiPath + "/image";

export const BaseDataPath = AppUrl + "/data";
export const BaseTreeDataPath = BaseDataPath + "/tree";

export const PhotosEndpoints = {
	listPhotos: `${PhotosApiPath}`,
	deletePhoto: (uuid) => `${PhotosApiPath}/${uuid}`,
	process: `${PhotosApiPath}/process`,
};

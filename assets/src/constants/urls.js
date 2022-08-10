// export const ApiUrl = process.env.SERVER_URL

export const AppUrl = import.meta.env.VITE_APP_URL
export const AppLoginUrl = AppUrl + "/auth/aad/new"
export const SocketPath = "/socket"

export const BaseApiPath = AppUrl + "/api"
export const UserPath = BaseApiPath + "/user"
export const PhotosApiPath = BaseApiPath + "/image"

export const BaseDataPath = AppUrl + "/data"
export const BaseTreeDataPath = BaseDataPath + "/tree"

export const WhoAmIPath = UserPath + "/whoami"

export const PhotosEndpoints = {
	listPhotos: `${PhotosApiPath}`,
	deletePhoto: (uuid) => `${PhotosApiPath}/${uuid}`,
	process: `${PhotosApiPath}/process`
}

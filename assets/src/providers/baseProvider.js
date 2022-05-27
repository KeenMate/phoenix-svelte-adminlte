import JwtDecode from "jwt-decode"

const ContentType = "Content-Type"

const Authorization = "Authorization"
//import {Json} from "../constants/contentTypes"
let Json = "application/json"
//import {DomainUrl, LoginPath} from "../constants/urls"
//import {LocalStorageAccessTokenKey} from "../constants/keys"
// import toastr from "../helpers/toastr-helpers"

export default class BaseProvider {
	/**
	 * @typedef Header
	 * @type {object}
	 * @param key {string}
	 * @param value {string}
	 */

	/**
	 * @type {string}
	 */
	static accessToken

	/**
	 * @type {boolean}
	 */
	static localStorageAccessTokenTried = false

	/**
	 * Unified fetch helper
	 * @param method {string} Method of HTTP request
	 * @param url {string} Just url
	 * @param body {any} Request body
	 * @param customHeaders {Header[]} Headers appended to HTTP request headers
	 * @param shouldDecode {Boolean} if set to true this method will try to decode response as json
	 // * @param requireAccessToken {Boolean} If set to true, will wait for access
	 * @throws {Response} if response status is not 200
	 * @return {Promise<Response | any>} If response's ContentType is set to json it automatically decodes given value
	 */
	async fetchResource(
		method,
		url,
		body = undefined,
		customHeaders = null,
		shouldDecode = true
		// requireAccessToken = true
	) {
		// if (requireAccessToken && !BaseProvider.accessToken) {
		// 	await BaseProvider.fetchAccessTokenWithLoginRedirect(false)
		// }

		const headers = this.mergeHeaders(
			BaseProvider.getCommonHeaders(),
			customHeaders
		)

		const response = await fetch(url, {
			method,
			headers,
			credentials: "include",
			body: JSON.stringify(body)
		})

		if (!response.ok) {
			console.error("Not OK result received", response)
			throw response
		}
		if (response.status === 401) {
			console.warn("resource returned 401 status. asking for access token")
			await BaseProvider.fetchAccessTokenWithLoginRedirect(false)

			return this.fetchResource.apply(this, arguments)
		}
		if (response.status === 403) {
			// toastr.error("Insufficient rights", "")
			return null
		}
		if (response.status < 200 || response.status > 300)
			throw response

		return (shouldDecode && response.json()) || response
	}

	/**
	 * Creates query string from given object
	 * @param queryObject {object}
	 */
	createQueryString(queryObject) {
		const queryPairs = Object.keys(queryObject)
			.map(key => `${key}=${encodeURI(queryObject[key] || "")}`)
			.filter(x => x)

		return (queryPairs.length && "?" + queryPairs.join("&")) || ""
	}

	/**
	 * Used to get url of specific endpoint that given provider is made for
	 */
	getEndpointUrl() {
		throw new Error(
			"Method `getEndpointUrl` must be overriden to provide specific api endpoint url"
		)
	}

	// clearSessionStorage() {
	// 	localStorage.removeItem(LocalStorageAccessTokenKey)
	// }

	/**
	 * Merges tobeMerged into headers
	 * @param headers {Headers} Headers to be merged into (is modified in-place)
	 * @param tobeMerged {Header[]} Headers to merge
	 * @return {Headers} Result (same as `headers` param, just for convenience)
	 */
	mergeHeaders(headers, tobeMerged) {
		if (!tobeMerged || !tobeMerged.length) return headers

		tobeMerged.forEach(({key, value}) => {
			headers.append(key, value)
		})

		return headers
	}

	/**
	 * Used to retrieve content type header
	 * @param headers {Headers}
	 * @return {string | null}
	 */
	static getContentType(headers) {
		return headers.get(ContentType)
	}

	/**
	 * Returns common headers used for communication with API
	 * Contains authorization header that is filled with `BaseProvider.accessToken` therefore it assumes that its already
	 * set
	 * @return {Headers}
	 */
	static getCommonHeaders() {
		const headersObject = {
			[ContentType]: Json
		}

		if (BaseProvider.accessToken)
			headersObject[Authorization] = `Bearer ${BaseProvider.accessToken}`

		return new Headers(headersObject)
	}

	static async fetchAccessTokenWithLoginRedirect(withRedirect = true) {
		try {
			await BaseProvider.fetchAccessToken()
		} catch (err) {
			console.error("Got error during fetching access token", err)

			if (err.message == 401)
				if (withRedirect)
					BaseProvider.redirectToLogin()
				else
					window.dispatchEvent(new RefreshTokenExpired())
		}
	}

	// static redirectToLogin(redirectTo) {
	// 	window.location.replace(BaseProvider.getLoginUrl(redirectTo))
	// }

	// static loginPopup(redirectTo) {
	// 	return window.open(BaseProvider.getLoginUrl(redirectTo), "_bank", "width=400,height=475")
	// }

	// static getLoginUrl(redirectTo) {
	// 	return `${LoginPath}${redirectTo || window.location.href}`
	// }

	/**
	 * Fetches global access token from API endpoint and stores it globally
	 * @deprecated Access token is not needed
	 * @returns {Promise}
	 */
	static async fetchAccessToken() {
		// makes request manually (not using helpers from this class intentionally)

		// access token is not needed
		// if (BaseProvider.fetchingAccessToken)
		// 	return new Promise(resolve => {
		// 		const interval = setInterval(() => {
		// 			if (BaseProvider.fetchingAccessToken || !BaseProvider.accessToken)
		// 				return
		// 			clearInterval(interval)
		// 			resolve()
		// 		}, 50)
		// 	})
		//
		// const tokenFromLocalStorage = localStorage.getItem(
		// 	LocalStorageAccessTokenKey
		// )
		// const now = new Date()
		//
		// if (
		// 	tokenFromLocalStorage
		// 	&& !BaseProvider.localStorageAccessTokenTried
		// ) {
		// 	const decodedToken = JwtDecode(tokenFromLocalStorage)
		// 	const tokenExp = new Date(decodedToken.exp * 1000)
		//
		// 	if (tokenExp > now) {
		// 		BaseProvider.localStorageAccessTokenTried = true
		// 		BaseProvider.accessToken = tokenFromLocalStorage
		// 		BaseProvider.setTokenRefreshTimer(decodedToken.exp)
		//
		// 		return
		// 	}
		// 	localStorage.removeItem(LocalStorageAccessTokenKey)
		// } else {
		// 	localStorage.removeItem(LocalStorageAccessTokenKey)
		// 	BaseProvider.localStorageAccessTokenTried = false
		// }
		//
		// BaseProvider.fetchingAccessToken = true
		//
		// const accessTokenResponse = await fetch(
		// 	`${AccessTokenPath}`,
		// 	{
		// 		method: "get",
		// 		credentials: "include"
		// 	}
		// )
		//
		// BaseProvider.fetchingAccessToken = false
		//
		// if (!accessTokenResponse.ok && accessTokenResponse.status === 401) {
		// 	console.error("Response is 401")
		// 	localStorage.removeItem(LocalStorageAccessTokenKey)
		// 	throw new Error(401)
		// }
		//
		// if (
		// 	accessTokenResponse.headers
		// 		.get("content-type")
		// 		.indexOf("application/json") === -1
		// )
		// 	throw new Error("Access token should have arrived with json content type")
		//
		// const decodedBody = await accessTokenResponse.json()
		// BaseProvider.setAccessToken(decodedBody.access_token)
	}

	static setTokenRefreshTimer(exp) {
		const tokenExpDate = new Date(exp * 1000)
		const now = new Date()
		const requestTokenAfter = (tokenExpDate - now) * 0.9
		setTimeout(() => {
			BaseProvider.fetchAccessToken()
		}, requestTokenAfter)
	}

	// static setAccessToken(token) {
	// 	BaseProvider.accessToken = token
	// 	BaseProvider.localStorageAccessTokenTried = false
	// 	localStorage.setItem(
	// 		LocalStorageAccessTokenKey,
	// 		token
	// 	)

	// 	const newDecodedAccessToken = JwtDecode(token)

	// 	BaseProvider.setTokenRefreshTimer(newDecodedAccessToken.exp)
	// }

	// static logout() {
	// 	localStorage.removeItem(LocalStorageAccessTokenKey)
	// 	window.location.href = `${DomainUrl}/auth/logout`
	// }
}

export class RefreshTokenExpired extends Event {
	constructor() {
		super("refreshtokenexpired")
	}
}

BaseProvider.fetchAccessTokenWithLoginRedirect()

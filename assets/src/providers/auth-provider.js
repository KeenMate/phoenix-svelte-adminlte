import {get} from "svelte/store"
import {Toastr} from "svelte-adminlte"
import {_} from "svelte-i18n"
import BaseProvider from "./baseProvider"
import {GET} from "../constants/methods"
import {WhoAmIPath} from "../constants/urls"

export class AuthProvider extends BaseProvider {
	async whoami() {
		const response = await this.fetchResource(GET, WhoAmIPath)

		return response.data
	}
}

export default new AuthProvider()

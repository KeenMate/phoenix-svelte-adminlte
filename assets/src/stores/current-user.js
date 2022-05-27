import {get, writable} from "svelte/store"
import AuthProvider from "../providers/auth-provider"
import {isAuthenticated, userInfo} from "./authentication"
import {Toastr} from "svelte-adminlte"
import {_} from "svelte-i18n"

const currentUserStore = writable(null)

export async function loadCurrentUser() {
	try {
		const currentUser = await AuthProvider.whoami()

		if (currentUser) {
			currentUserStore.set(currentUser)
			userInfo.set(currentUser)
			isAuthenticated.set(true)
		}
	} catch (error) {
		// Toastr.error(get(_("auth.messages.currentUserNotLoaded")))
		//
		// return null
	}
}

export default currentUserStore

import { get, writable } from "svelte/store"
import { Socket } from "phoenix"
import { Toastr } from "@keenmate/svelte-adminlte";

import { SocketPath } from "../../constants/urls"

const socket = writable(null)

export const socketConnected = writable(false)

export function initSocket() {
	const existing = get(socket)
	if (existing) {
		existing.disconnect()
	}

	console.log("Connecting to:", SocketPath)

	const socketInstance = new Socket(SocketPath)

	socketInstance.onClose(() => {
		Toastr.warning("Spojení přerušeno!")
		socketConnected.set(false)
	})
	socketInstance.onOpen(() => {
		Toastr.success("Spojení navázáno!")
		socketConnected.set(true)
	})
	socketInstance.onError(error => {
		console.error("Error occured in socket connection", ...arguments)
		if (error === "expired") {
			Toastr.warning("Autorizovaná seance vypršela")
			redirectToLogin()
		} else
			Toastr.error("Nastala chyba při komunikaci se serverem")
	})

	console.log("Connecting to socket")
	socketInstance.connect()

	socket.set(socketInstance)

	return socketInstance
}

export default socket

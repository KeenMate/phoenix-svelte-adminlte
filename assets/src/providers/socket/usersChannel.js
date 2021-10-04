import { pushSocketMessage } from "./common"
import { Channel } from "./channel"

const usersChannel = new Channel("users:lobby")

export async function getAllUsers() {
	const channel = await usersChannel.get()

	return await pushSocketMessage(channel, "get_all_users")
}

export default usersChannel

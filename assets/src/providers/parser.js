import {invert} from "lodash"
import aad from "../constants/aadFields"

const reversedAadUserMapping = invert(aad.user)

export function parseUser(user) {
	return Object.keys(user)
		.reduce((acc, key) => {
			return {
				...acc,
				[reversedAadUserMapping[key]]: user[key]
			}
		}, {})
}

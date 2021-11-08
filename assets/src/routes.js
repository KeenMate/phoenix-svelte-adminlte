import Route1 from "./routes/Route1.svelte"
import Users from "./routes/Users.svelte"
import Tree from "./routes/Tree.svelte"
import List from "./routes/List.svelte"
import NotFound from "./routes/NotFound.svelte"
import Error from "./routes/Error.svelte"
import LocaleEditor from "./routes/LocaleEditor.svelte"

export const Routes = [
	{
		name: "UserProfileInfo",
		title: "Profile Info",
		route: "/",
		breadcrumb: ["Route 1"],
		icon: "fas fa-id-badge"
	},
	{
		name: "Error",
		title: "Error",
		route: "/error",
		breadcrumb: ["Error"],
		hide: true
	},
	{
		name: "Users",
		title: "Users",
		route: "/users",
		breadcrumb: ["Users"],
		icon: "fas fa-users"
	},
	{
		name: "Tree",
		title: "Tree",
		route: "/tree",
		breadcrumb: ["Tree"],
		icon: "fas fa-stream"

	},
	{
		name: "List",
		title: "List",
		route: "/list",
		breadcrumb: ["List"],
		icon: "fas fa-list-ul"

	},
	{
		name: "Locale",
		title: "Locale editor",
		route: "/locale-editor",
		breadcrumb: ["Locale editor"],
		icon: "fas fa-language"
	}
]

export const Urls = Routes
	.reduce((acc, x) => {
		acc[x.name] = x.route
		return acc
	}, {})

export function fillParams(route, params) {
	return Object
		.keys(params)
		.reduce(
			(acc, key) => acc.replace(`:${key}`, params[key]),
			route
		)
}

export function routeToRegex(route) {
	return "^" + route.replace(/\/:\w+(\??)/, "/?([\\w\-\d]+)$1") + "$"
}

export default {
	[Urls.UserProfileInfo]: Route1,
	[Urls.Users]: Users,
	[Urls.Tree]: Tree,
	[Urls.List]: List,
	[Urls.Error]: Error,
	[Urls.Locale]: LocaleEditor,
	// The catch-all route must always be last
	"*": NotFound
}

/**
 * @param source {({id: number})[]}
 * @param sourceKey {string} key to look for in source when trying to distinguish items
 * @param startIndex {number}
 * @param endIndex {number}
 * @param operation {"select" | "deselect"}
 * @param alreadySelectedIds {number[]}
 * @return {number[]} New selected ids
 */

export default function selectMany(
	source,
	sourceKey,
	startIndex,
	endIndex,
	operation,
	alreadySelectedIds
) {
	const direction = startIndex - endIndex;

	let imagesOfMatter = null;
	// right direction
	if (direction < 0)
		imagesOfMatter = source.slice(startIndex + 1, endIndex + 1);
	else if (direction > 0)
		imagesOfMatter = source.slice(endIndex, startIndex + 1);
	else return alreadySelectedIds;

	// check if last image was selected (if so select all images) (deselect all images otherwise)
	const imagesOfMatterIds = imagesOfMatter.map((x) => x[sourceKey]);
	switch (operation) {
		case "select":
			return [
				...imagesOfMatterIds.filter((x) => !alreadySelectedIds.includes(x)),
				...alreadySelectedIds,
			];
		// alreadySelectedIds.splice(0, 0, ...imagesOfMatterIds
		// 	.filter(x => !alreadySelectedIds.includes(x)))
		case "deselect":
			return alreadySelectedIds.filter((x) => !imagesOfMatterIds.includes(x));
	}
}

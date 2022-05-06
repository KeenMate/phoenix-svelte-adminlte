// const purgecss = require('@fullhuman/postcss-purgecss')({
//   content: ['./**/**/*.html', './**/**/*.svelte'],
//   whitelistPatterns: [/svelte-/],
//   defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || []
// });
const production = process.env.MIX_ENV === "prod"

module.exports = {
  plugins: [
    require("postcss-import"),
    require("autoprefixer"),
    production ? require("cssnano") : false,
    //...(production ? [purgecss] : []),
  ],
};
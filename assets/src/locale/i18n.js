import { addMessages } from 'svelte-i18n';
import { register, init, getLocaleFromNavigator ,locale } from 'svelte-i18n';

import en from './en.json';
import cs from './cs.json';
import { registerLocaleLoader } from 'svelte-i18n/types/runtime/includes/loaderQueue';

export function changeLang(lang){
  console.log(lang);
  locale.set(lang);
  console.log(locale);
}
export {locale};

export const languages = ["cs","en"];
addMessages('en', en);
addMessages('cs', cs);

init({
  fallbackLocale: 'en',
  initialLocale: getLocaleFromNavigator(),
});
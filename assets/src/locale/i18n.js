import { addMessages } from 'svelte-i18n';
import { register, init, getLocaleFromNavigator } from 'svelte-i18n';

import en from './en.json';
import cz from './cz.json';

addMessages('en', en);
addMessages('cz', cz);

init({
  fallbackLocale: 'en',
  initialLocale: getLocaleFromNavigator(),
});
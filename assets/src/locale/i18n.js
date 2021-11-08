import { addMessages } from 'svelte-i18n';
import { register, init, getLocaleFromNavigator ,locale } from 'svelte-i18n';

import en from './en.json';
import cs from './cs.json';
import { registerLocaleLoader } from 'svelte-i18n/types/runtime/includes/loaderQueue';

export function changeLang(lang){
  console.log(lang);
  locale.set(lang);
  console.log(getLocaleFromNavigator())
}
export {locale};

export const languages = [{code:"cs" , img: "cz",title:"cestina"},{code:"en" , img: "gb"},{code:"en-US" , img: "us"}];
addMessages('en', en);
addMessages('cs', cs);

init({
  fallbackLocale: 'cs',
  initialLocale: getLocaleFromNavigator(),
});

export function GetFlagPath(country_code){
  let lang = languages.find(x => x.code === country_code);
  if( lang != undefined)
    return "img/flags/" + lang.img + ".png"
  return "";

}



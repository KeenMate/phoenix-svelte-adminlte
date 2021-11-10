import { addMessages } from 'svelte-i18n';
import { register, init, getLocaleFromNavigator ,locale } from 'svelte-i18n';

import en from './en.json';
import cs from './cs.json';
import langs from "./langs.json";
import { registerLocaleLoader } from 'svelte-i18n/types/runtime/includes/loaderQueue';

export function changeLang(lang){
  if(languages.find(x => x.code === lang.substring(0,2)) != undefined){
    console.log("changing lang to:",lang)
    locale.set(lang);
    localStorage.setItem("language",lang)
  }else{
    console.log("ERROR: language " +  lang ," does not exist")
  }
  return 
}
export {locale,en,cs,langs};

export const languages = langs;
addMessages('en', en);
addMessages('cs', cs);

init({
  fallbackLocale: 'cs',
  initialLocale: localStorage.getItem("language") || getLocaleFromNavigator(),
});


export function GetFlagPath(country_code){
  let lang = languages.find(x => x.code === country_code.substring(0,2));
  if( lang != undefined)
    return "img/flags/" + lang.img + ".png"
  return "";

}

export function saveLanguageFile(json,lang){
addMessages(lang,json);
console.log("SAVING TO FILE :)")  
console.log(cs)
}


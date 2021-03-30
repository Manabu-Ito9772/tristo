import Vue from 'vue'
import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { faThumbsUp, faTimesCircle, faEye, faEyeSlash } from '@fortawesome/free-regular-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

library.add(fas, faThumbsUp, faTimesCircle, faEye, faEyeSlash)
Vue.component('FontAwesomeIcon', FontAwesomeIcon)

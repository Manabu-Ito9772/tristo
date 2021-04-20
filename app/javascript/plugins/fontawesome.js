import Vue from 'vue'
import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { faThumbsUp, faHeart, faTimesCircle, faEye, faEyeSlash, faCircle } from '@fortawesome/free-regular-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

library.add(fas, faThumbsUp, faHeart, faTimesCircle, faEye, faEyeSlash, faCircle)
Vue.component('FontAwesomeIcon', FontAwesomeIcon)

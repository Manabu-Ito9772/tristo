import Vue from 'vue'

import {
  ValidationProvider,
  ValidationObserver,
  extend
} from 'vee-validate'

import {
  email,
  required,
  numeric
} from 'vee-validate/dist/rules';

Vue.component('ValidationObserver', ValidationObserver)
Vue.component('ValidationProvider', ValidationProvider)

extend('required', {
  ...required,
  message: '{_field_}は必須項目です'
})

extend('country', {
  ...required,
  message: '国は必須項目です'
})

extend('prefecture', {
  ...required,
  message: '都道府県は必須項目です'
})

extend('numeric', {
  ...numeric,
  message: '{_field_}は半角数字で入力してください'
})

extend('max', {
  validate(value, { length }) {
    return value.length <= length;
  },
  params: ['length'],
  message: '{_field_}は{length}文字以下で入力してください'
})

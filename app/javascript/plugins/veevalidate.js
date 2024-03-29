import Vue from 'vue'

import {
  ValidationProvider,
  ValidationObserver,
  extend
} from 'vee-validate'

import {
  email,
  required,
  numeric,
  image,
  size
} from 'vee-validate/dist/rules';

Vue.component('ValidationObserver', ValidationObserver)
Vue.component('ValidationProvider', ValidationProvider)

extend('required', {
  ...required,
  message: '{_field_}は必須項目です'
})

extend('input', {
  ...required,
  message: '{_field_}を入力してください'
})

extend('email', {
  ...email,
  message: '{_field_}の形式で入力してください'
})

extend('country', {
  ...required,
  message: '国は必須項目です'
})

extend('prefecture', {
  ...required,
  message: '都道府県は必須項目です'
})

extend('mean', {
  ...required,
  message: '手段を選択してください'
})

extend('numeric', {
  ...numeric,
  message: '{_field_}は半角数字で入力してください'
})

extend('image', {
  ...image,
  message: '{_field_}は画像形式で入力してください'
})

extend('size', {
  ...size,
  message: '{_field_}は5MB以下にしてください'
})

extend('max', {
  validate(value, { length }) {
    return value.length <= length
  },
  params: ['length'],
  message: '{_field_}は{length}文字以下で入力してください'
})

extend('min', {
  validate(value, { length }) {
    return value.length >= length
  },
  params: ['length'],
  message: '{_field_}は{length}文字以上で入力してください'
})

extend('password_format', {
  validate(value) {
    const regex = new RegExp(/^[a-zA-Z0-9!-/:-@¥[-`{-~]+$/)
    return regex.test(value)
  },
  message: '{_field_}は半角英数字・記号で入力してください'
})

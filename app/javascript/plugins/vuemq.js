import Vue from 'vue'
import VueMq from 'vue-mq'

Vue.use(VueMq, {
  breakpoints: {
    xs: 600,
    sm: 800,
    lg: Infinity
  },
  defaultBreakpoint: 'md'
})

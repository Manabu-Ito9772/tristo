import Vue from 'vue';
import Router from 'vue-router';

import ArticleIndex from "../pages/article/index";

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: ArticleIndex,
      name: 'ArticleIndex',
    },
  ]
})

export default router

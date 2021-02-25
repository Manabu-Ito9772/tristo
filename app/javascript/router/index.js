import Vue from 'vue';
import Router from 'vue-router';

import ArticleIndex from "../pages/article/index";
import ArticleShow from "../pages/article/show";

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: ArticleIndex,
      name: 'ArticleIndex'
    },
    {
      path: '/article',
      component: ArticleShow,
      name: 'ArticleShow',
      props: true
    },
  ]
})

export default router

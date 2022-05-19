import * as VueRouter from 'vue-router';

import Rating from './components/Rating.vue'
import Category from './components/Category.vue';
import Login from './components/Login.vue';
import Signup from './components/Signup.vue';
import Event from './components/Event.vue';

const routes = [
    { path: '/', component: Signup, name: "Signup" },
    { path: '/category', component: Category, name: "Categories" },
    { path: '/login', component: Login, name: "Login" },
    { path: '/rating', component: Rating },
    { path: '/create-event', component: Event, name: "CreateEvent" },
];

const router = VueRouter.createRouter({
    history: VueRouter.createWebHistory(),
    mode: 'history',
    routes, // short for `routes: routes`
});

export default router;
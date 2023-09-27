import * as Vue from 'vue';
import PostActions from '../vue_components/PostActions'

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('post-actions').forEach((el) => {
    const reactions = JSON.parse(el.getAttribute('reactions'))
    const user_id = JSON.parse(el.getAttribute('user_id'))
    const post_id = JSON.parse(el.getAttribute('post_id'))

    const comments = JSON.parse(el.getAttribute('comments'))

    const app = Vue.createApp(PostActions, { reactions: reactions, user_id: user_id, post_id: post_id, comments: comments });
    app.mount(el);
  });
});


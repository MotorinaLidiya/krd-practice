<template>
  <div class="row">
    <div class="col-6">
      <reactions :reactions="reactions" :user_id="user_id" :post_id="post_id"/>
    </div>
    <div class="col-6 text-end">
      <comments :comments="comments" :user_id="user_id" :post_id="post_id"/>
    </div>
  </div>
</template>

<script>
import Reactions from "./Reactions";
import Comments from "./Comments";

export default {
  name: 'PostActions',
  props: {
    reactions: Object,
    comments: Object,

    user_id: Number,
    post_id: Number
  },
  components: {
    Reactions,
    Comments
  }
}
</script>

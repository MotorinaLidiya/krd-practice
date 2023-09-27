<template>
  <div>
    <div v-on:click="clickLike" class='btn-outline-background btn btn-sm me-2 text-dark'>
      <span class='me-2'>{{ like }}</span>
      <i class='fa fa-thumbs-up' :class="likeIsPressed ? 'text-success' : ''"/>
    </div>
    <div  v-on:click="clickDisike" class='btn-outline-background btn btn-sm me-2 text-dark'>
      <span class='me-2'>{{ dislike }}</span>
      <i class='fa fa-thumbs-down' :class="dislikeIsPressed ? 'text-danger' : ''"/>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'Reactions',
  data() {
    return {
      like: 0,
      likeIsPressed: false,
      dislike: 0,
      dislikeIsPressed: false,
    }
  },
  props: {
    reactions: Object,
    user_id: Number,
    post_id: Number,
  },
  mounted() {
    this.serialize_reaction(this.reactions)
  },
  methods: {
    serialize_reaction(reactions) {
      if (reactions) {
        this.like = reactions['like'] || 0
        this.dislike = reactions['dislike'] || 0
        this.likeIsPressed = reactions['user'] == 'like'
        this.dislikeIsPressed = reactions['user'] == 'dislike'
      }
      else {
        this.like = 0
        this.dislike = 0
        this.likeIsPressed = false
        this.dislikeIsPressed = false
      }
    },
    clickLike() {
      axios.post('/api/post_reactions/like', { data: { user_id: this.user_id, post_id: this.post_id } }).then(res => {
        this.serialize_reaction(res.data)
      })
    },
    clickDisike () {
      axios.post('/api/post_reactions/dislike', { data: { user_id: this.user_id, post_id: this.post_id } }).then(res => {
        this.serialize_reaction(res.data)
      })
    }
  }
}
</script>

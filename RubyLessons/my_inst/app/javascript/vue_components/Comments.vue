<template>
  <div>
    <div v-on:click="show_comments = !show_comments" class="btn btn-outline-theme text-dark btn-sm">
      {{ count }} comments
    </div>
    <div v-if="show_comments">
      <div class="mt-2 border border-theme text-start" v-for="message in messages">
        <div class="row">
          <div class="col-6">Author: {{ message['email'] }}</div>
          <div class="col-6 text-end">Created at: {{ message['created_at'] }}</div>
        </div>
        <div class="bg-theme d-flex justify-content-between align-items-center">
          <div>{{ message['body'] }}</div>
          <div v-on:click="deleteMessage(message['id'])" v-if="user_id == message['user_id']" class="btn"><i class="fa fa-trash-o"/></div>
        </div>
      </div>
      <div class="mt-2 text-start">Write a comment:</div>
      <div class="row">
        <div class="col-10">
          <input v-on:keyup.enter="sendMessage" class="form-control" v-model="message"/>
        </div>
        <div class="col-2">
          <div v-on:click="sendMessage" class="btn btn-outline-theme text-dark"><i class="fa fa-paper-plane"/></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'Comments',
  props: {
    comments: Object,
    user_id: Number,
    post_id: Number,
  },
  data() {
    return {
      count: 0,
      messages: {},
      show_comments: false,
      message: ''
    }
  },
  mounted() {
    this.serialize_comment(this.comments)
  },
  methods: {
    serialize_comment(comments) {
      if (comments) {
        this.count = comments['count']
        this.messages = comments['comments']
      }
      else {
        this.count = 0
        this.messages = {}
      }
    },
    sendMessage() {
      axios.post('/api/post_comments', { data: { author_id: this.user_id, post_id: this.post_id, body: this.message } }).then(res => {
        this.serialize_comment(res.data)
        this.message = ''
      })
    },
    deleteMessage(message_id) {
      if(confirm("Sure you want to delete this?")) {
        axios.delete(`/api/post_comments/${message_id}`, { data: { author_id: this.user_id, post_id: this.post_id } }).then(res => {
          this.serialize_comment(res.data)
        })
      }
    }
  }
}
</script>

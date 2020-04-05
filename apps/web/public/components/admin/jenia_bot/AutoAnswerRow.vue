<template>
  <tr>
    <th>{{ id }}</th>
    <td>{{ author_id }}</td>
    <td>{{ chat_id }}</td>
    <td>{{ trigger }}</td>
    <td>{{ answer }}</td>
    <td></td>
    <td>{{ approved }}</td>
    <td>{{ created_at }}</td>
    <td></td>
    <td>
      <button @click="deleteRecord(id)" class="button is-small is-danger">Delete</button>
    </td>
  </tr>
</template>

<script>
module.exports = {
  props: [
    'id',
    'author_id',
    'chat_id',
    'trigger',
    'answer',
    'approved',
    'created_at',
  ],

  methods: {
    deleteRecord(id) {
      axios.delete('/admin/jenia_bot/auto_answers/' + id).then(response => {
        window.location.href = '/admin/jenia_bot/auto_answers/';
      }).catch(error => {});
    }
  }
}
</script>

<style scoped>
input {
  width: 100px;
}
</style>
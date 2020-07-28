<template>
  <tr>
    <th>{{ id }}</th>
    <td>{{ chat_id }}</td>
    <td>{{ question }}</td>
    <td></td>
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
    'chat_id',
    'question',
    'created_at',
  ],

  methods: {
    deleteRecord(id) {
      axios.delete('/admin/jenia_bot/questions/' + id).then(response => {
        window.location.href = '/admin/jenia_bot/questions/';
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
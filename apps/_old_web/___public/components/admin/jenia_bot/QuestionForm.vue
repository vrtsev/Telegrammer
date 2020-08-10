<template>
  <div>
    <button @click="toggleFormVisibility" class="button is-primary">Create new</button>

    <div v-show="visible">
      <form method="post" action="/admin/jenia_bot/questions">
        <table class="table" width="600">
          <thead>
            <tr>
              <th>id</th>
              <th>chat</th>
              <th>question</th>
              <th></th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <th></th>
              <td><input name="chat_id" style="width: 80px" type="text" placeholder="chat"></td>
              <td><input name="text"   style="width: 200px" type="text" placeholder="trigger"></td>
              <td></td>
              <td>
                <input type="submit" class="button is-primary" name="Create"/>
              </td>
            </tr>
          </tbody>
        </table>
      </form>
    </div>
  </div>
</template>

<script>
module.exports = {
  data: function () {
    return {
      visible: false,
    }
  },
  methods: {
    toggleFormVisibility() {
      this.visible = !this.visible
    }
  }
}
</script>

<style scoped>
input {
  width: 100px;
}
</style>
<template>
  <aside class="sidebar menu block">
    <p class="menu-label">
      Instruments
    </p>
    <ul class="menu-list">
      <li><a href="https://logs.vrtsev.dev/">Logs</a></li>
      <li><a href="https://adminer.vrtsev.dev/">Adminer</a></li>
      <li><a href="https://redis.vrtsev.dev/">Redis</a></li>
      <li><a href="https://sidekiq.socialup.vrtsev.dev/">Sidekiq</a></li>
      <li><a href="/">To public page</a></li>
      <li><a href="/admin/dashboard">Dashboard</a></li>
    </ul>

    <hr>

    <p class="menu-label">
      JeniaBot
    </p>
    <ul class="menu-list">
      <li><a href="/admin/jenia_bot/auto_answers">AutoAnswers</a></li>
      <li><a href="/admin/jenia_bot/questions">Quetions</a></li>
      <li><a href="/admin/jenia_bot/messages/new">Send message</a></li>
    </ul>

    <hr>

    <p class="menu-label">
      PdrBot
    </p>
    <ul class="menu-list">
      <li><a href="/admin/pdr_bot/messages/new">Send message</a></li>
    </ul>
  </aside>
</template>

<script>
</script>

<style scoped>
.sidebar {
  width: 400px;
  margin: 0 !important;
  background-color: #eaeaea;
}
</style>
var app = new Vue({
  el: '#admin',
  components: {
    'navbar': window.httpVueLoader('/components/admin/Navbar.vue'),
    'auto-answer-form': window.httpVueLoader('/components/admin/jenia_bot/AutoAnswerForm.vue'),
    'auto-answer-row': window.httpVueLoader('/components/admin/jenia_bot/AutoAnswerRow.vue'),
    'question-form': window.httpVueLoader('/components/admin/jenia_bot/QuestionForm.vue'),
    'question-row': window.httpVueLoader('/components/admin/jenia_bot/QuestionRow.vue'),
  },
})

Routes = [
  {
    path: '/',
    to: HomeController,
    name: 'home_path'
  },
  {
    path: '/auth',
    to: AuthController,
    name: 'auth_path',
  },
  {
    path: '/admin/dashboard',
    to: Admin::DashboardController,
    name: 'admin_dashboard_path'
  },

  {
    path: '/admin/jenia_bot/auto_answers',
    to: Admin::JeniaBot::AutoAnswersController,
    name: 'admin_jenia_bot_auto_answers_path'
  },
  {
    path: '/admin/jenia_bot/questions',
    to: Admin::JeniaBot::QuestionsController,
    name: 'admin_jenia_bot_questions_path'
  },
  {
    path: '/admin/jenia_bot/messages',
    to: Admin::JeniaBot::MessagesController,
    name: 'admin_jenia_bot_messages_path'
  },

  {
    path: '/admin/pdr_bot/messages',
    to: Admin::PdrBot::MessagesController,
    name: 'admin_pdr_bot_messages_path'
  },
]

module Admin
  module JeniaBot
    class AutoAnswersController# < ::AdminController
#       get '/' do
#         @auto_answers = ::JeniaBot::AutoAnswerRepository.new.get_all_desc
#         render_html 'admin/jenia_bot/auto_answers/index'
#       end

#       post '/' do
#         result = ::AdminBot::Op::JeniaBot::AutoAnswer::Create.call(params: params)

#         session[:flash] = { error: result[:error] } unless result.success?
#         redirect to('/')
#       end

#       delete '/:id' do
#         auto_answer = ::JeniaBot::AutoAnswerRepository.new.find(params[:id])

#         auto_answer ? auto_answer.delete : session[:flash] = { error: 'Could not find record' }
#         redirect to('/')
#       end
    end
  end
end

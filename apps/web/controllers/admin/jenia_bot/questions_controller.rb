module Admin
  module JeniaBot
    class QuestionsController < ::AdminController
      get '/' do
        @questions = ::JeniaBot::QuestionRepository.new.get_all_desc
        render_html 'admin/jenia_bot/questions/index'
      end

      post '/' do
        result = ::AdminBot::Op::JeniaBot::Question::Create.call(params: params)

        session[:flash] = { error: result[:error] } unless result.success?
        redirect to('/')
      end

      delete '/:id' do
        question = ::JeniaBot::QuestionRepository.new.find(params[:id])

        question ? question.delete : session[:flash] = { error: 'Could not find record' }
        redirect to('/')
      end
    end
  end
end

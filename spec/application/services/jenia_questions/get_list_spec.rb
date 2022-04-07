# frozen_string_literal: true

RSpec.describe JeniaQuestions::GetList do
  subject { described_class.call(params) }

  it_should_behave_like 'invalid service'

  context 'when params valid' do
    let(:params) { Hash[chat_id: chat.id] }
    let(:chat) { create(:chat) }

    let(:questions) { [question1.text, question2.text, question3.text] }

    let!(:question1) { create(:jenia_question, chat: chat, text: 'How are you?') }
    let!(:question2) { create(:jenia_question, chat: chat, text: 'Wazzup?') }
    let!(:question3) { create(:jenia_question, chat: chat, text: 'Are you ok?') }

    it { expect(subject.questions).to include(*questions) }
  end
end

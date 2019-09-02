# RSpec.describe AdminBot::Controller, telegram_bot: :poller do

#   let(:bot) { Telegram.bots[:admin_bot] }
#   let(:current_user) { Fabricate(:admin_bot_user, role: AdminBot::User::Roles.administrator) }

#   let(:default_message_options) do
#     {
#       message_id: Faker::Number.number(digits: 4),
#       text: text,
#       from: from,
#       chat: chat,
#       date: Time.now.to_i
#     }
#   end

#   let(:from) { { id: current_user.id } }
#   let(:chat) { { id: Faker::Number.number(digits: 4), type: 'private', title: 'Some chat' } }
#   let(:text) { 'allala' }


#   def callback_query
#     # # There is context for callback queries with related matchers,
#     # # use :callback_query tag to include it.
#     # describe '#hey_callback_query', :callback_query do
#     #   let(:data) { "hey:#{name}" }
#     #   let(:name) { 'Joe' }
#     #   it { should answer_callback_query('Hey Joe') }
#     #   it { should edit_current_message :text, text: 'Done' }
#     # end
#   end


#   describe 'Admin Bot' do
#     describe 'admin_bot' do
#     end

#     describe '#start!' do
#       context 'when called by callback query'
#         subject { -> { answer_callback_query('bot:admin_bot,action:start!') } }

#         it { expect(subject).to send_telegram_message(bot) }
#       context 'when called by command' do
#         subject { -> { dispatch_command(:start!) } }
#         it { expect(subject).to send_telegram_message(bot) }
#       end
#     end
#   end




#   describe 'Jenia Bot' do
#     describe 'jenia_bot' do
#     end

#     describe '#jenia_bot_start!' do
#     end

#     describe '#jenia_bot_say!' do
#     end

#     describe '#jenia_bot_current_state!' do
#     end

#     describe '#jenia_bot_change_state!' do
#     end

#     describe '#jenia_bot_question!' do
#     end

#     describe '#jenia_bot_auto_answer!' do
#     end
#   end



#   describe 'Pdr Bot' do
#     describe 'pdr_bot' do
#     end

#     describe '#pdr_bot_start!' do
#     end

#     describe '#pdr_bot_say!' do
#     end

#     describe '#pdr_bot_current_state!' do
#     end

#     describe '#pdr_bot_change_state!' do
#     end

#     describe '#pdr_bot_auto_answer!' do
#     end
#   end



























#   # describe '#message' do

#   #   describe 'message' do
#   #     context "when is trigger for 'jenia!' method" do
#   #       let(:text) { described_class::JENIA_METHOD_TRIGGERS.sample }
#   #       subject { -> { dispatch_message(text) } }

#   #       it { expect(subject).to send_telegram_message(bot) }
#   #     end

#   #     context "when does not match with 'jenia!' method triggers" do
#   #       describe 'operation' do
#   #         context 'when is successful' do
#   #           describe 'auto answer by received' do
#   #             let!(:auto_answer) { Fabricate(:jenia_bot_auto_answer) }
#   #             subject { -> { dispatch_message(text) } }

#   #             context 'when not found' do
#   #               let(:text) { 'Some random text' }

#   #               it { expect(auto_answer.answer).not_to eq(text) }
#   #               it { expect(subject).not_to send_telegram_message(bot, auto_answer.answer) }
#   #             end

#   #             context 'when exists and found' do
#   #               let(:text) { auto_answer.trigger_message }

#   #               it { expect(auto_answer.trigger_message).to eq(text) }
#   #               it { expect(subject).to send_telegram_message(bot, auto_answer.answer) }
#   #             end
#   #           end
#   #         end
#   #       end
#   #     end
#   #   end
#   # end

#   # subject { -> { dispatch_command command } }

#   # describe '#start!' do
#   #   let(:command) { :start }

#   #   it { expect(subject).to send_telegram_message(bot) }
#   # end

#   # describe '#jenia!' do
#   #   let(:command) { :jenia }

#   #   it { expect(subject).to send_telegram_message(bot) }
#   # end
# end

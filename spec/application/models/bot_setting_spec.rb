# frozen_string_literal: true

RSpec.describe BotSetting, type: :model do
  context 'validations' do
    subject { create(:bot_setting) }

    it { is_expected.to validate_presence_of(:bot) }
  end
end

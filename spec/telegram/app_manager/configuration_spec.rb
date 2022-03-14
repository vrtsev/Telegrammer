# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Configuration do
  subject { described_class.new }

  let(:instance_variables) { [:@app_name, :@telegram_bot, :@controller, :@controller_logging] }
  let(:app_name) { 'ExampleBot' }
  let(:telegram_bot) { Telegram.bots[:example_bot] }
  let(:controller) { ExampleBot::Controller }
  let(:controller_logging) { false }

  it { expect(subject.instance_variables).to eq(instance_variables) }

  it 'changes values of null instance variables' do
    expect { subject.app_name = app_name }.to change { subject.app_name }.from(nil).to(app_name)
    expect { subject.telegram_bot = telegram_bot }.to change { subject.telegram_bot }.from(nil).to(telegram_bot)
    expect { subject.controller = controller }.to change { subject.controller }.from(nil).to(controller)
    expect { subject.controller_logging = controller_logging }
      .to change { subject.controller_logging }
      .from(described_class::DEFAULT_CONTROLLER_LOGING_ENABLED).to(controller_logging)
  end
end

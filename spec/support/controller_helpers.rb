# frozen_string_literal: true

RSpec.shared_context 'controller_helpers' do
  before do
    allow(Chat).to receive(:for_app_owner).and_return(app_owner_chat)
    allow_any_instance_of(described_class).to receive(:rand).and_return(stubbed_delay)
  end

  let(:app_owner_chat) { create(:chat) }
  let(:stubbed_delay) { 1 }

  # Service helpers
  def allow_service_call(service_class)
    allow(service_class).to receive(:call)
  end

  def expect_service_call(service_class, service_params = nil)
    expect(service_class).to receive(:call).with(service_params).once
    subject
  end

  # Message helpers
  def expect_sent_message(message_params = nil)
    message_expectation(:send_message, message_params)
    subject
  end

  def expect_reply_message(message_params = nil)
    message_expectation(:reply_message, message_params)
    subject
  end

  def message_expectation(action, message_params = nil)
    expect_any_instance_of(described_class).to receive(action).with(message_params)
  end
end
# frozen_string_literal: true

RSpec.describe Messages::Sync do
  subject { described_class.call(params) }

  let(:bot) { create(:bot, name: 'example_bot', username: 'example_bot') }
  let(:chat_user) { create(:chat_user) }
  let(:reply_message) { create(:message, bot: bot) }
  let(:payload) { base_payload.merge('text' => 'Message text') }
  let(:base_payload) do
    {
      'message_id' => 123,
      'date' => 1655241255,
      'reply_to_message' => {
        'message_id' => reply_message.external_id
      }
    }
  end
  let(:params) do
    {
      bot_id: bot.id,
      payload: payload,
      chat_user_id: chat_user.id
    }
  end

  it { expect(subject.success?).to be_truthy }

  it { expect { subject }.to change { chat_user.chat.messages.count }.by(1) }

  it 'sets proper attributes' do
    expect(subject.message).to have_attributes(
      chat_user_id: chat_user.id,
      external_id: payload['message_id'],
      created_at: Time.at(payload['date']),
      text: payload['text'],
      bot_id: bot.id,
      reply_to_id: reply_message.id,
      payload_type: Message.payload_types[:text],
      content_url: nil,
      content_data: nil
    )
  end

  describe 'payload type' do
    before { allow_any_instance_of(Telegram::AppManager::Client).to receive(:file_url).and_return('https://file_url') }

    context 'when photo' do
      let(:payload) { base_payload.merge('photo' => [{ 'file_id' => 'ADCD:1234' }]) }

      it 'sets proper attributes' do
        expect(subject.message).to have_attributes(
          payload_type: Message.payload_types[:photo],
          content_url: 'https://file_url',
          content_data: { 'file_id' => 'ADCD:1234' }
        )
      end
    end

    context 'when video' do
      let(:payload) { base_payload.merge('video' => { 'file_id' => 'ADCD:1234' }) }

      it 'sets proper attributes' do
        expect(subject.message).to have_attributes(
          payload_type: Message.payload_types[:video],
          content_url: 'https://file_url',
          content_data: { 'file_id' => 'ADCD:1234' }
        )
      end
    end

    context 'when document' do
      let(:payload) { base_payload.merge('document' => { 'file_id' => 'ADCD:1234' }) }

      it 'sets proper attributes' do
        expect(subject.message).to have_attributes(
          payload_type: Message.payload_types[:document],
          content_url: 'https://file_url',
          content_data: { 'file_id' => 'ADCD:1234' }
        )
      end
    end

    context 'when sticker' do
      let(:payload) { base_payload.merge('sticker' => { 'thumb' => { 'file_id' => 'ADCD:1234' } }) }

      it 'sets proper attributes' do
        expect(subject.message).to have_attributes(
          payload_type: Message.payload_types[:sticker],
          content_url: 'https://file_url',
          content_data: { 'thumb' => { 'file_id' => 'ADCD:1234' }}
        )
      end
    end

    context 'when animation' do
      let(:payload) { base_payload.merge('animation' => { 'file_id' => 'ADCD:1234' }) }

      it 'sets proper attributes' do
        expect(subject.message).to have_attributes(
          payload_type: Message.payload_types[:animation],
          content_url: 'https://file_url',
          content_data: { 'file_id' => 'ADCD:1234' }
        )
      end
    end

    context 'when voice' do
      let(:payload) { base_payload.merge('voice' => { 'file_id' => 'ADCD:1234' }) }

      it 'sets proper attributes' do
        expect(subject.message).to have_attributes(
          payload_type: Message.payload_types[:voice],
          content_url: 'https://file_url',
          content_data: { 'file_id' => 'ADCD:1234' }
        )
      end
    end

    context 'when video_note' do
      let(:payload) { base_payload.merge('video_note' => { 'file_id' => 'ADCD:1234' }) }

      it 'sets proper attributes' do
        expect(subject.message).to have_attributes(
          payload_type: Message.payload_types[:video_note],
          content_url: 'https://file_url',
          content_data: { 'file_id' => 'ADCD:1234' }
        )
      end
    end
  end
end

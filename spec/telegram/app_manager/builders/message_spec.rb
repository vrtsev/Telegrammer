# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Builders::Message do
  describe '.build' do
    subject { described_class.build(**params) }

    let(:params) { Hash[payload: payload, chat_user_id: chat_user.id, bot: bot] }
    let(:bot) { Telegram.bots[:example_bot] }
    let(:chat_user) { create(:chat_user) }
    let(:payload) { Telegram::Bot::Types::Message.new(payload_params)  }
    let(:base_payload_params) { Hash[message_id: 123456789, date: 1649255514] }

    let(:text) { nil }
    let(:content_url) { nil }
    let(:content_data) { nil }

    shared_examples_for 'hash with proper attributes' do
      it 'returns hash with proper attributes' do
        is_expected.to eq(
          payload_type: payload_type,
          chat_user_id: chat_user.id,
          external_id: 123456789,
          text: text,
          content_url: content_url,
          content_data: content_data,
          created_at: Time.at(1649255514)
        )
      end
    end

    context 'when text' do
      let(:payload_type) { 'text' }
      let(:payload_params) { base_payload_params.merge(text: 'Payload text') }
      let(:text) { 'Payload text' }

      it_should_behave_like 'hash with proper attributes'
    end

    context 'with content_url' do
      let(:telegram_bot) { Telegram.bots[:example_bot] }
      let(:telegram_bot_token) { 12345 }
      let(:file_id) { 'AgACAgIAAxkBAA' }
      let(:file_unique_id) { 'AQADwboxG2aaaa' }
      let(:file_path) { nil }
      let(:content_url) { "https://api.telegram.org/file/bot#{telegram_bot_token}/#{file_path}" }
      let(:api_response) do
        {
          'ok' => true,
          'result' => {
            'file_id' => file_id,
            'file_unique_id' => file_unique_id,
            'file_size' => 165217,
            'file_path' => file_path
          }
        }
      end

      before do
        allow_any_instance_of(described_class).to receive(:telegram_bot).and_return(telegram_bot)
        allow(telegram_bot).to receive(:token).and_return(telegram_bot_token)
        allow(telegram_bot).to receive(:request).and_return(api_response)
      end

      context 'when photo' do
        let(:payload_type) { 'photo' }
        let(:payload_params) { base_payload_params.merge(photo: photo_payload) }
        let(:photo_payload) { [Telegram::Bot::Types::PhotoSize.new(file_id: file_id, file_unique_id: file_unique_id, width: 1240, height: 1130, file_size: 12345)] }
        let(:file_path) { 'photos/file_1.jpg' }

        it_should_behave_like 'hash with proper attributes'
      end

      context 'when video' do
        let(:payload_type) { 'video' }
        let(:payload_params) { base_payload_params.merge(video: video_payload) }
        let(:video_payload) { Telegram::Bot::Types::Video.new(file_id: file_id, file_unique_id: file_unique_id, width: 432, height: 216, duration: 9, thumb: nil) }
        let(:file_path) { 'videos/file_2.jpg' }

        it_should_behave_like 'hash with proper attributes'
      end

      context 'when document' do
        let(:payload_type) { 'document' }
        let(:payload_params) { base_payload_params.merge(document: document_payload) }
        let(:document_payload) { Telegram::Bot::Types::Document.new(file_id: file_id, file_unique_id: file_unique_id, thumb: nil) }
        let(:file_path) { 'documents/file_3.mp4' }

        it_should_behave_like 'hash with proper attributes'
      end

      context 'when sticker' do
        let(:payload_type) { 'sticker' }
        let(:payload_params) { base_payload_params.merge(sticker: sticker_payload) }
        let(:sticker_payload) { Telegram::Bot::Types::Sticker.new(file_id: file_id, file_unique_id: file_unique_id, width: 512, height: 453, is_animated: false, thumb: nil) }
        let(:file_path) { 'stickers/file_4.webp' }

        it_should_behave_like 'hash with proper attributes'
      end

      context 'when animation' do
        let(:payload_type) { 'animation' }
        let(:payload_params) { base_payload_params.merge(animation: animation_payload) }
        let(:animation_payload) { Telegram::Bot::Types::Animation.new(file_id: file_id, file_unique_id: file_unique_id, width: 512, height: 453, is_animated: false) }
        let(:file_path) { 'animations/file_5.mp4' }

        it_should_behave_like 'hash with proper attributes'
      end

      context 'when voice' do
        let(:payload_type) { 'voice' }
        let(:payload_params) { base_payload_params.merge(voice: voice_payload) }
        let(:voice_payload) { Telegram::Bot::Types::Voice.new(file_id: file_id, file_unique_id: file_unique_id, duration: 1, mime_type: 'audio/ogg', file_size: 7530) }
        let(:file_path) { 'voice/file_6.oga' }

        it_should_behave_like 'hash with proper attributes'
      end

      context 'when video_note' do
        let(:payload_type) { 'video_note' }
        let(:payload_params) { base_payload_params.merge(video_note: video_note_payload) }
        let(:video_note_payload) { Telegram::Bot::Types::VideoNote.new(file_id: file_id, file_unique_id: file_unique_id, length: 300, duration: 2, thumb: nil) }
        let(:file_path) { 'video_notes/file_7.mp4' }

        it_should_behave_like 'hash with proper attributes'
      end
    end

    context 'with content_data' do
      let(:content_data) { data_payload.to_h }

      context 'when poll' do
        let(:payload_type) { 'poll' }
        let(:payload_params) { base_payload_params.merge(poll: data_payload) }
        let(:data_payload) do
          Telegram::Bot::Types::Poll.new(
            id: '5161215161318171216',
            question: 'Poll question',
            options: [
              Telegram::Bot::Types::PollOption.new(text: 'First option', voter_count: 0),
              Telegram::Bot::Types::PollOption.new(text: 'Second option', voter_count: 0)
            ],
            total_voter_count: 0,
            is_closed: false,
            is_anonymous: true,
            type: 'regular',
            allows_multiple_answers: false,
            explanation: nil
          )
        end

        it_should_behave_like 'hash with proper attributes'
      end

      context 'when location' do
        let(:payload_type) { 'location' }
        let(:payload_params) { base_payload_params.merge(location: data_payload) }
        let(:data_payload) { Telegram::Bot::Types::Location.new(longitude: 24.021374, latitude: 49.816678) }

        it_should_behave_like 'hash with proper attributes'
      end

      context 'when contact' do
        let(:payload_type) { 'contact' }
        let(:payload_params) { base_payload_params.merge(contact: data_payload) }
        let(:data_payload) { Telegram::Bot::Types::Contact.new(phone_number: '+380905080707', first_name: 'Contact name', last_name: nil, user_id: 1014191011, vcard: nil) }

        it_should_behave_like 'hash with proper attributes'
      end
    end
  end
end

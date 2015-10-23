require 'google/apis/gmail_v1'
require 'vi_gmail/message_header'

module ViGmail
  class Mail
    attr_reader :service
    GMAIL = Google::Apis::GmailV1

    def initialize
      @service = GMAIL::GmailService.new
      @service.authorization = GoogleClient.new.authorize
    end

    def save_to_db
      messages_response = service.list_user_messages('me', fields: 'messages/id')

      messages_response.messages.map(&:id).each do |message_id|
        source_message = service.get_user_message('me', message_id)
        message_header = MessageHeader.new(source_message.payload.headers)

        save_message(source_message, message_header)
      end
    end

    class << self
      def inbox
        Message.select(:id, :subject).map(&:attributes)
      end
    end

    private

    def save_message(source_message, message_header)
      message = Message.new(message_header.attributes)
      message.source_id = source_message.id
      message.plain_body = source_message.payload.parts.first.body.data
      message.save!
    end
  end
end

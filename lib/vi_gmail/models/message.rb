require 'vi_gmail/message_header'

class Message < ActiveRecord::Base
  has_one :detail, class_name: 'MessageDetail', dependent: :destroy
  has_many :labels
  belongs_to :user
  belongs_to :thread, class_name: 'MessageThread', foreign_key: :thread_id

  class << self
    def create_messages(thread, source_messages)
      source_messages.each do |source_message|
        message_header = ViGmail::MessageHeader.new(source_message.payload.headers)
        message = Message.new(message_header.attributes)
        message.attributes = { user_id: thread.user_id, source_id: source_message.id,
                               snippet: source_message.snippet, thread_id: thread.id }
        message.save!

        message.build_detail.create_record(message_header, source_message)

        Label.create_labels(message, source_message.label_ids)
      end
    end
  end
end

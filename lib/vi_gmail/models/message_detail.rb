class MessageDetail < ActiveRecord::Base
  encode :plain_body

  belongs_to :message

  def create_record(message_header, source_message)
    self.to = message_header.find_value('To')
    self.plain_body = source_message.payload.parts.first.body.data
    save!
  end
end

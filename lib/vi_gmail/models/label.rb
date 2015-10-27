class Label < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  scope :inbox, -> { where('name = ?', 'INBOX') }
  scope :unread, -> { where('name = ?', 'UNREAD') }

  class << self
    def create_labels(message, label_names)
      label_names.each do |label_name|
        create!(user_id: message.user_id, message_id: message.id, name: label_name)
      end
    end
  end
end

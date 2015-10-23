class MessageThread < ActiveRecord::Base
  has_many :messages, foreign_key: :thread_id
  belongs_to :user

  class << self
    def create_threads(user, mail, source_threads)
      source_threads.each do |source_thread|
        thread = create!(user_id: user.id, source_id: source_thread.id)

        thread_with_messages = mail.fetch_thread(source_thread.id)
        Message.create_messages(thread, thread_with_messages.messages)
      end
    end
  end
end

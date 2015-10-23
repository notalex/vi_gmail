require 'google/apis/gmail_v1'

module ViGmail
  class Mail
    attr_reader :service
    GMAIL = Google::Apis::GmailV1

    def initialize
      @service = GMAIL::GmailService.new
      @service.authorization = GoogleClient.new.authorize
      @user = User.first
    end

    def save_to_db
      list_thread_response = service.list_user_threads('me')
      MessageThread.create_threads(@user, self, list_thread_response.threads.reverse)
      PollHistory.save_history_id(@user, list_thread_response.threads.last.history_id)
    end

    def fetch_thread(source_thread_id)
      service.get_user_thread('me', source_thread_id)
    end

    class << self
      def inbox
        Message.select(:id, :subject).map(&:attributes)
      end
    end
  end
end

module ViGmail
  class VimWriter
    def setup_inbox(email)
      user = User.find_by(email: email)
      file_path = "/tmp/INBOX_#{ user.email }"
      file = File.open(file_path, 'w')

      user.message_threads.joins(:messages).order('messages.date DESC').limit(50).uniq.each do |message_thread|
        message = message_thread.messages.last
        file.puts message.printable_values.join(' | ')
      end

      file.close
      file_path
    end
  end
end

require 'test_helper'

describe ViGmail::VimWriter do
  let(:user) { create(:user) }
  let(:thread) { create(:message_thread, user: user) }

  before do
    create_list(:message, 2, thread: thread, user: user)
    create(:message, user: user)
  end

  describe 'drb_client setup_inbox' do
    before do
      setup_vim
    end

    after do
      kill_vim
    end

    it 'must load a file with inbox data' do
      vim.edit 'file.txt'
      vim.normal(":ViGmail #{ user.email } <CR>")
      sleep 2
      line_contents = vim.echo("getline('.')")

      message = thread.messages.last
      line_contents.must_match message.subject
      line_contents.must_match message.snippet
    end
  end

  describe 'setup_inbox' do
    include DbCleaner

    it 'must populate file with inbox data' do
      thread = create(:message_thread, user: user)
      message = create(:message, user: user, thread: thread)
      message.labels.create!(name: 'UNREAD')
      thread_2 = create(:message_thread, user: user)
      message_2 = create(:message, user: user, thread: thread_2)

      vim_writer = ViGmail::VimWriter.new

      file_path = vim_writer.setup_inbox(user.email)

      file_path.must_match /\/tmp.+#{ user.email }/
      file_contents = File.readlines(file_path)
      content = file_contents.find { |text| text.match(message.thread_id.to_s) }
      content.strip.must_equal message.printable_values.join(' | ')
    end
  end
end

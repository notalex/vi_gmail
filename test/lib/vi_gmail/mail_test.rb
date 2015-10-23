require 'test_helper'

describe ViGmail::Mail do
  describe 'save_to_db' do
    before do
      User.create!(email: 'vi.mail.tester@gmail.com', name: 'Vigmail')
      ViGmail::GoogleClient.any_instance.stubs(:authorize)
    end

    it 'must save all current mails to db' do
      VCR.use_cassette('save_to_db') do
        ViGmail::Mail.new.save_to_db

        Message.count.must_equal 7

        message = Message.first
        message.detail.to.must_equal 'vi.mail.tester@gmail.com'
        message.detail.plain_body.must_match /Hey Vimail/
        message.thread.subject.must_equal 'Getting started on Google+'
        message.thread.snippet.must_match /Welcome to Google+/
        message.thread.snippet.must_equal message.snippet
        message.labels.map(&:name).must_equal %w[CATEGORY_SOCIAL INBOX UNREAD]
        message.date.to_s.must_equal '2015-10-23 14:24:00 UTC'

        thread = Message.all[2].thread
        thread.messages.count.must_equal 2
        thread.subject.must_equal 'Re: ViGmail Test'

        PollHistory.count.must_equal 1
        PollHistory.first.last_fetched_id.must_equal '1138'
      end
    end
  end
end

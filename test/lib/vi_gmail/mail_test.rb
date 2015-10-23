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
        message.detail.to.must_equal 'Vimail Tester <vi.mail.tester@gmail.com>'
        message.detail.plain_body.must_match /Bring your contacts and mail into Gmail/
        message.subject.must_equal 'Three tips to get the most out of Gmail'
        message.snippet.must_match /Hi Vimail Tips to get the most out of Gmail/
        message.labels.map(&:name).must_equal %w[INBOX UNREAD]
        message.date.to_s.must_equal '2015-09-17 09:30:58 UTC'

        thread = Message.all[4].thread
        thread.messages.count.must_equal 2
        thread.messages.last.subject.must_equal 'Re: ViGmail Test'

        PollHistory.count.must_equal 1
        PollHistory.first.last_fetched_id.must_equal '1138'
      end
    end
  end
end

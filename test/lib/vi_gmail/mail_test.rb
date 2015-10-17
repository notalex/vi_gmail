require 'test_helper'

describe ViGmail::Mail do
  describe 'save_to_db' do
    before do
      ViGmail::GoogleClient.any_instance.stubs(:authorize)
    end

    it 'must save all current mails to db' do
      VCR.use_cassette('save_to_db') do
        ViGmail::Mail.new.save_to_db

        Message.count.must_equal 6
      end
    end
  end
end

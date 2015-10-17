require 'vi_gmail/app'
require 'vi_gmail/initializers/setup_active_record'
require 'vi_gmail/initializers/active_record_extensions'
require 'vi_gmail/models'
require 'vi_gmail/mail'

module ViGmail
  extend self

  def start
    ViGmail::Mail.new.save_to_db
  end
end

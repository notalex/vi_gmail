require 'drb'
require 'vi_gmail/app'
require 'vi_gmail/initializers/setup_active_record'
require 'vi_gmail/initializers/active_record_extensions'
require 'vi_gmail/models'
require 'vi_gmail/google_client'
require 'vi_gmail/mail'
require 'vi_gmail/server'

$SAFE = 1

module ViGmail
  extend self

  def start
    DRb.start_service(nil, ViGmail::Mail)
    DRb.uri
  end
end

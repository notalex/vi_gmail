require 'server_manager'

module ViGmail
  module Server
    module_function

    def start
      ServerManager.drb_uri = ViGmail.start
      DRb.thread.join
    end
  end
end

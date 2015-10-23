require 'drb'

module ServerManager
  extend self

  DRB_URI_FILE_PATH = File.expand_path('../../tmp/drb_uri', __FILE__)

  def start_server
    kill_any_existing_servers
    start_new_server
  end

  def drb_uri
    File.read(DRB_URI_FILE_PATH) if File.exists?(DRB_URI_FILE_PATH)
  end

  def drb_uri=(new_drb_uri)
    File.open(DRB_URI_FILE_PATH, 'w') { |f| f.puts(new_drb_uri) }
  end

  private

  def start_new_server
    bin_path = File.expand_path('../../bin', __FILE__)
    system("#{ bin_path }/vi_gmail_server &")
  end

  def kill_any_existing_servers
    process_ids = %x(pgrep -f vi_gmail_server).split.map(&:to_i)

    process_ids.each do |process_id|
      Process.kill(:TERM, process_id)
    end
  end
end

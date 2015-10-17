require 'active_record'
require 'yaml'

class SetupActiveRecord
  def initialize
    ActiveRecord::Base.establish_connection(db_config)
  end

  def db_config
    db_configurations = YAML.load_file(ViGmail::App.db_config_file_path)
    db_configurations[ENV['VI_GMAIL_ENV']]
  end
end

SetupActiveRecord.new

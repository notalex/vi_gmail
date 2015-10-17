require 'yaml'
require 'fileutils'

module ViGmail
  class SetupDefaultDbConfig
    def initialize
      copy_config unless File.exists?(App.db_config_file_path)
    end

    def copy_config
      Dir.mkdir(App.db_config_folder_path) rescue nil

      FileUtils.cp(default_db_config_path, App.db_config_file_path)
    end

    private

    def default_db_config_path
      App.root.join('db/config.yml')
    end
  end
end

ViGmail::SetupDefaultDbConfig.new

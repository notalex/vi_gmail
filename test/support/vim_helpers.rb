class MiniTest::Spec
  private

  def setup_vim
    vim.command("cd #{ tmp_dir_path }")
    vim.add_plugin(ENV['VI_GMAIL_PLUGIN_PATH'], 'plugin/vi_gmail.vim')
  end

  def vim
    @vim ||= Vimrunner.start
  end

  def kill_vim
    FileUtils.remove_entry(tmp_dir_path)
    vim.kill
    ServerManager.kill_any_existing_servers
  end

  def tmp_dir_path
    @tmp_dir_path ||= Dir.mktmpdir('vimrunner')
  end
end

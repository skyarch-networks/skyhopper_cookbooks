require File.expand_path('../support/helpers.rb', __FILE__)

describe 'zabbix::default' do
  include Helpers::Zabbix

  it "creates a user for the daemon to run as" do
      user("zabbix").must_exist
  end

  it 'runs as a daemon' do
    service("zabbix_agentd").must_be_running
  end
end
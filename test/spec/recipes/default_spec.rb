require 'spec_helper'

describe 'confd::default' do
  context 'with default attributes' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge('confd::default')
    end

    it { expect(chef_run).to include_recipe('rc::default') }
    it do
      expect(chef_run).to create_remote_file('/opt/confd/bin/confd-0.10.0-linux-amd64')
      .with(source: 'https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64')
    end
    it { expect(chef_run).to create_directory('/etc/confd/templates') }
    it { expect(chef_run).to create_directory('/etc/confd/conf.d') }
    it { expect(chef_run).to create_directory('/opt/confd/bin') }
    it do
      expect(chef_run).to create_link('/opt/confd/bin/confd-0.10.0-linux-amd64')
      .with(to: '/usr/local/bin/confd')
    end
  end

  context "with node['confd']['install_method'] == 'package'" do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.set['confd']['install_method'] = 'package'
      end.converge('confd::default')
    end

    it { expect(chef_run).to include_recipe('rc::default') }
    it { expect(chef_run).to create_directory('/etc/confd/templates') }
    it { expect(chef_run).to create_directory('/etc/confd/conf.d') }
    it { expect(chef_run).not_to create_directory('/opt/confd/bin') }
    it { expect(chef_run).to upgrade_package('confd') }
  end
end

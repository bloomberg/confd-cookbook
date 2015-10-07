require 'spec_helper'
require 'poise_boiler/spec_helper'

describe ConfdCookbook::Resource::ConfdService do
  recipe { confd_service 'confd' }

  context 'with default attributes' do
    it { is_expected(chef_run).to create_directory('/etc/confd/templates') }
    it { is_expected(chef_run).to create_directory('/etc/confd/conf.d') }
    it { is_expected(chef_run).to create_directory('/var/run/confd') }
    it { is_expected(chef_run).to create_directory('/opt/confd/bin') }

    it do
      is_expected(chef_run).to create_link('/opt/confd/bin/confd-0.10.0-linux-amd64')
      .with(to: '/usr/local/bin/confd')
    end

    it do
      is_expected(chef_run).to create_remote_file('/opt/confd/bin/confd-0.10.0-linux-amd64')
      .with(source: 'https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64')
    end
  end

  context "with node['confd']['service']['install_method'] == 'package'" do
    it { is_expected(chef_run).to create_directory('/etc/confd/templates') }
    it { is_expected(chef_run).to create_directory('/etc/confd/conf.d') }
    it { is_expected(chef_run).to create_directory('/var/run/confd') }
    it { expect(chef_run).not_to create_directory('/opt/confd/bin') }
    it { expect(chef_run).to upgrade_package('confd') }
  end
end

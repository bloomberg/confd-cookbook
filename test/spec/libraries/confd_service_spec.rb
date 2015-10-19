require 'spec_helper'
require 'poise_boiler/spec_helper'

describe ConfdCookbook::Resource::ConfdService do
  step_into(:confd_service)
  recipe('confd::default')

  context 'with default attributes' do
    it { is_expected.to create_directory('/etc/confd/templates') }
    it { is_expected.to create_directory('/etc/confd/conf.d') }
    it { is_expected.to create_directory('/var/run/confd') }
    it { is_expected.to create_directory('/opt/confd/bin') }

    it do
      is_expected.to create_link('/usr/local/bin/confd')
      .with(to: '/opt/confd/bin/confd-0.10.0-linux-amd64')
    end

    it do
      is_expected.to create_remote_file('/opt/confd/bin/confd-0.10.0-linux-amd64')
      .with(source: 'https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64')
    end
  end
end

require 'spec_helper'
require 'poise_boiler/spec_helper'

describe ConfdCookbook::Resource::ConfdExecute do
  step_into(:confd_execute)
  recipe do
    confd_execute 'test' do
      onetime true
      nodes 'foo'
      action :run
    end
  end

  context 'with default attributes' do
    it { is_expected.to create_directory('/etc/confd').with(recursive: true) }
    it { is_expected.to run_execute('confd -interval 600 -prefix / -scheme http -confdir /etc/confd -onetime -node foo -config-file /etc/confd/confd.toml') }
  end
end

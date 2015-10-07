require 'spec_helper'

describe 'confd::default' do
  context 'with default attributes' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge('confd::default')
    end

    it { expect(chef_run).to include_recipe('rc::default') }
    it { expect(chef_run).to create_confd_config('confd').with(path: '/etc/confd/confd.toml') }
    it { expect(chef_run).to enable_confd_service('confd').with(config_path: '/etc/confd/confd.toml') }
  end
end

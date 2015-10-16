require 'serverspec'
set :backend, :exec

describe file('/etc/confd/confd.toml') do
  it { should be_file }
end

describe file('/etc/confd/conf.d') do
  it { should be_directory }
end

describe file('/etc/confd/templates') do
  it { should be_directory }
end

describe service('confd') do
  it { should be_running }
  it { should be_enabled }
end

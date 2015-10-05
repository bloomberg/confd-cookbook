#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
include_recipe 'rc::default'

[node['confd']['template_directory'], node['confd']['resource_directory']].each do |dirname|
  directory dirname do
    recursive true
  end
end

package node['confd']['package_name'] do
  version node['confd']['package_version']
  action :upgrade
  only_if { node['confd']['install_method'] == 'package' }
end

if node['confd']['install_method'] == 'binary'
  basename = File.basename(node['confd']['remote_url'])
  install_directory = directory File.join(node['confd']['install_path'], 'bin') do
    recursive true
  end

  remote_file File.join(install_directory.path, basename) do
    source node['confd']['remote_url']
    checksum node['confd']['remote_checksum']
  end

  link File.join(install_directory.path, basename) do
    to '/usr/local/bin/confd'
  end
end

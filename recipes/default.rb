#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

directory node['confd']['template_directory']
directory node['confd']['resource_directory']
directory node['confd']['install_path']

package node['confd']['package_name'] do
  version node['confd']['package_version']
  action :upgrade
  only_if { node['confd']['install_method'] == 'package' }
end

if node['confd']['install_method'] == 'binary'
  install_directory = directory File.join(node['confd']['install_path'], 'bin')

  remote_file File.join(install_directory.path, File.basename(node['confd']['remote_url'])) do
    source node['confd']['remote_url']
    checksum node['confd']['remote_checksum']
  end

  link File.join(install_directory.path, 'confd') do
    to '/usr/local/bin/confd'
  end
end

#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

default['confd']['template_directory'] = '/etc/confd/templates'
default['confd']['resource_directory'] = '/etc/confd/conf.d'

default['confd']['install_method'] = 'binary'
default['confd']['install_path'] = '/opt/confd'

default['confd']['package_name'] = 'confd'
default['confd']['package_version'] = '0.10'

default['confd']['remote_url'] = 'https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64'
default['confd']['remote_checksum'] = '9035fa8b23d9e776eca237a0a6bb15caa999d4767596362eea3e61c7b92ca88d'

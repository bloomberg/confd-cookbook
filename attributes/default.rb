#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

default['confd']['service_name'] = 'confd'

default['confd']['config'] = {}
default['confd']['service']['config_file'] = '/etc/confd/confd.toml'
default['confd']['service']['install_method'] = 'binary'
default['confd']['service']['install_path'] = '/opt/confd'

default['confd']['service']['remote_url'] = 'https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64'
default['confd']['service']['remote_checksum'] = '9035fa8b23d9e776eca237a0a6bb15caa999d4767596362eea3e61c7b92ca88d'

#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
include_recipe 'rc::default'

confd_config node['confd']['service_name'] do |r|
  path node['confd']['service']['config_file']

  node['confd']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :restart, "confd_service[#{name}]", :delayed
end

confd_service node['confd']['service_name'] do |r|
  node['confd']['service'].each_pair { |k, v| r.send(k, v) }
end

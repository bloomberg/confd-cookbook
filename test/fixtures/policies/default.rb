name 'default'
default_source :community
default_source :chef_repo, '..'
cookbook 'confd', path: '../../..'
run_list 'zookeeper-cluster::default', 'confd::default'
named_run_list :centos, 'yum::default', run_list
named_run_list :debian, 'apt::default', run_list
named_run_list :freebsd, 'freebsd::default', run_list
named_run_list :windows, 'windows::default', run_list
override['zookeeper-cluster']['config']['instance_name'] = 'localhost'
override['zookeeper-cluster']['config']['ensemble'] = 'localhost'
override['confd']['config']['backend'] = 'zookeeper'
override['confd']['config']['nodes'] = 'localhost'

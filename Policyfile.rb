name 'confd'
run_list 'confd::default'
default_source :community
cookbook 'confd', path: '.'

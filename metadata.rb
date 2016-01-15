name 'confd'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache 2.0'
description 'Application cookbook which installs and configures confd.'
long_description 'Application cookbook which installs and configures confd.'
version '1.1.2'

supports 'ubuntu', '>= 12.04'
supports 'redhat', '>= 5.8'
supports 'centos', '>= 5.8'

depends 'poise', '~> 2.2'
depends 'poise-service', '~> 1.0'
depends 'rc', '~> 1.3'

source_url 'https://github.com/bloomberg/confd-cookbook' if defined?(source_url)
issues_url 'https://github.com/bloomberg/confd-cookbook/issues' if defined?(issues_url)

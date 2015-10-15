require 'chefspec'
require 'chefspec/policyfile'
require 'chefspec/cacher'
require_relative '../../libraries/confd_config'
require_relative '../../libraries/confd_execute'
require_relative '../../libraries/confd_service'
require_relative '../../libraries/confd_template'

RSpec.configure do |c|
  c.platform = 'ubuntu'
  c.version = '14.04'
end

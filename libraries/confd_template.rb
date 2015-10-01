#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

require 'poise'

module ConfdCookbook
  module Resource
    class ConfdTemplate < Chef::Resource
      include Poise(fused: true)
      provides(:confd_template)

      action(:create) do

      end

      action(:destroy) do

      end
    end
  end
end

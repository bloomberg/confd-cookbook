#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

require 'poise'

module ConfdCookbook
  module Resource
    class ConfdExecute < ConfdCookbook::Resource::ConfdConfig
      include Poise(fused: true)
      provides(:confd_execute)

      action(:run) do
        notifying_block do
          execute new_resource.command do
            environment('PATH' => '/usr/local/bin:/usr/bin:/bin')
          end
        end
      end
    end
  end
end

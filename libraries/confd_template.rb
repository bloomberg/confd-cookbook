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

      attribute('', template: true)
      attribute(:owner, kind_of: String)
      attribute(:group, kind_of: String)
      attribute(:mode, kind_of: String, default: '0640')

      action(:create) do
        notifying_block do
          file new_resource.path do
            content new_resource.content
            owner new_resource.owner
            group new_resource.group
            mode new_resource.mode
          end
        end
      end

      action(:destroy) do
        notifying_block do
          file new_resource.path do
            action :delete
          end
        end
      end
    end
  end
end

#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

require 'poise'

module ConfdCookbook
  module Resource
    # A resource for managing confd templates.
    # @since 1.0.0
    class ConfdTemplate < Chef::Resource
      include Poise(fused: true)
      provides(:confd_template)

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:template_directory, kind_of: String, default: '/etc/confd/templates')
      attribute(:resource_directory, kind_of: String, default: '/etc/confd/conf.d')

      attribute(:keys, kind_of: Array, default: [])
      attribute('template', template: true)

      def to_toml
      end

      action(:create) do
        notifying_block do
          [new_resource.template_directory, new_resource.resource_directory].each do |dirname|
            directory ::File.dirname(dirname) do
              recursive true
            end
          end

          file new_resource.template_path do
            content new_resource.template_content
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

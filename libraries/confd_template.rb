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
      attribute(:owner, kind_of: String)
      attribute(:group, kind_of: String)
      attribute(:mode, kind_of: String, default: '0644')

      attribute(:template_directory, kind_of: String, default: '/etc/confd/templates')
      attribute(:resource_directory, kind_of: String, default: '/etc/confd/conf.d')

      attribute(:prefix, kind_of: String)
      attribute(:keys, kind_of: [String, Array], required: true)
      attribute(:check_command, kind_of: String)
      attribute(:reload_command, kind_of: String)

      attribute('template', template: true)

      action(:create) do
        uid = Etc.getpwnam(new_resource.owner) if new_resource.owner
        gid = Etc.getgrnam(new_resource.group) if new_resource.group

        notifying_block do
          [new_resource.template_directory, new_resource.resource_directory].each do |dirname|
            directory ::File.dirname(dirname) do
              recursive true
            end
          end

          basename = ::File.basename(new_resource.path)
          file ::File.join(new_resource.template_directory, basename) do
            content new_resource.template_content
          end

          basename = ::File.basename(new_resource.path) + '.tmpl'
          config = {
            'keys' => [new_resource.keys].flatten,
            'dest' => new_resource.path,
            'src' => basename
          }
          config['uid'] = uid if uid
          config['gid'] = gid if gid
          config['prefix'] = new_resource.prefix if new_resource.prefix
          config['mode'] = new_resource.mode if new_resource.mode
          config['check_cmd'] = new_resource.check_command if new_resource.check_command
          config['reload_cmd'] = new_resource.reload_command if new_resource.reload_command

          rc_file ::File.join(new_resource.resource_directory, basename) do
            type 'toml'
            options('template' => config)
          end
        end
      end

      action(:destroy) do
        notifying_block do
          basename = ::File.basename(new_resource.path) + '.tmpl'
          file ::File.join(new_resource.template_directory, basename) do
            action :delete
          end

          basename = ::File.basename(new_resource.path)
          rc_file ::File.join(new_resource.resource_directory, basename) do
            action :delete
          end
        end
      end
    end
  end
end

#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#

require 'poise_service/service_mixin'

module ConfdCookbook
  module Resource
    # A resource for managing running confd as a service.
    # @since 1.0.0
    class ConfdService < Chef::Resource
      include Poise
      provides(:confd_service)
      include PoiseService::ServiceMixin

      attribute(:config_file, kind_of: String, default: '/etc/confd/confd.toml')
      attribute(:directory, kind_of: String, default: '/var/run/confd')
      attribute(:install_method, equal_to: %w{package binary}, default: 'binary')
      attribute(:install_path, kind_of: String, default: '/opt/confd')
      attribute(:package_name, kind_of: String, default: 'confd')
      attribute(:package_version, kind_of: String)
      attribute(:remote_url, kind_of: String)
      attribute(:remote_checksum, kind_of: String)
      attribute(:template_directory, kind_of: String, default: '/etc/confd/templates')
      attribute(:resource_directory, kind_of: String, default: '/etc/confd/conf.d')
    end
  end

  module Provider
    # @since 1.0.0
    class ConfdService < Chef::Provider
      include Poise
      provides(:confd_service)
      include PoiseService::ServiceMixin

      def action_enable
        notifying_block do
          package new_resource.package_name do
            version new_resource.package_version
            action :upgrade
            only_if { new_resource.install_method == 'package' }
          end

          [new_resource.template_directory,
           new_resource.resource_directory,
           new_resource.directory].each do |dirname|
            directory dirname do
              recursive true
            end
          end

          if new_resource.install_method == 'binary'
            directory ::File.join(new_resource.install_path, 'bin') do
              recursive true
            end

            basename = ::File.basename(new_resource.remote_url)
            remote_file ::File.join(new_resource.install_path, 'bin', basename) do
              source new_resource.remote_url
              checksum new_resource.remote_checksum
              mode '0755'
            end

            link '/usr/local/bin/confd' do
              to ::File.join(new_resource.install_path, 'bin', basename)
            end
          end
        end
        super
      end

      def service_options(service)
        service.command("/usr/local/bin/confd -config-file #{new_resource.config_file}")
        service.directory(new_resource.directory)
        service.restart_on_update(true)
      end
    end
  end
end

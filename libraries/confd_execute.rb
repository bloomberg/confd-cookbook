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

      attribute(:config_file, kind_of: String, default: '/etc/confd/confd.toml')

      def command
        ['/usr/local/bin/confd'].tap do |c|
          c << ['-onetime', onetime]
          c << ['-interval', interval]
          c << ['-keep-stage', keep_stage]
          c << ['-prefix', prefix]
          c << ['-scheme', scheme]
          c << ['-confdir', confdir]
          c << ['-watch', watch]
          c << ['-nodes', [nodes].flatten.join(',')]
          c << ['-client-cakeys', client_cakeys] if client_cakeys
          c << ['-client-cert', client_cert] if client_cert
          c << ['-client-key', client_key] if client_key
          c << ['-config-file', config_file] if config_file
          c << ['-srv-domain', srv_domain] if srv_domain
        end.flatten.join(' ')
      end

      action(:run) do
        notifying_block do
          directory ::File.dirname(new_resource.config_file)

          execute new_resource.command
        end
      end
    end
  end
end

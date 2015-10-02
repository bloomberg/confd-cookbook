#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

module ConfdCookbook
  module Resource
    # @since 1.0.0
    class ConfdConfig < Chef::Resource
      include Poise
      provides(:confd_config)
      actions(:create, :delete)

      attribute(:onetime, equal_to: [true, false], default: lazy { default_onetime })
      attribute(:client_ca_keys, kind_of: String)
      attribute(:client_cert, kind_of: String)
      attribute(:client_key, kind_of: String)
      attribute(:confdir, kind_of: String, default: '/etc/confd')
      attribute(:config_file, kind_of: String)
      attribute(:keep_stage, equal_to: [true, false], default: false)
      attribute(:node, kind_of: [String, Array], required: true)
      attribute(:prefix, kind_of: String, default: '/')
      attribute(:scheme, equal_to: %w{http https}, default: 'http')
      attribute(:interval, kind_of: Integer, default: 600)
      attribute(:srv_domain, kind_of: String)
      attribute(:watch, equal_to: [true, false], default: false)

      def default_onetime
        true
      end

      def command
        ['confd'].tap do |c|
          c << ['-onetime', onetime]
          c << ['-interval', interval]
          c << ['-keep-stage', keep_stage]
          c << ['-prefix', prefix]
          c << ['-scheme', scheme]
          c << ['-confdir', confdir]
          c << ['-watch', watch]
          c << ['-node', [node].flatten.join(',')]
          c << ['-client-ca-keys', client_ca_keys] if client_ca_keys
          c << ['-client-cert', client_cert] if client_cert
          c << ['-client-key', client_key] if client_key
          c << ['-config-file', config_file] if config_file
          c << ['-srv-domain', srv_domain] if srv_domain
        end.flatten.join(' ')
      end
    end
  end

  module Provider
    # @since 1.0.0
    class ConfdConfig < Chef::Provider
      include Poise
      provides(:confd_config)

      def action_create
      end

      def action_delete
      end
    end
  end
end

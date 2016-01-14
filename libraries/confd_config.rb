#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#

require 'poise'

module ConfdCookbook
  module Resource
    # @since 1.0.0
    class ConfdConfig < Chef::Resource
      include Poise
      provides(:confd_config)
      actions(:create, :delete)

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:owner, kind_of: String)
      attribute(:group, kind_of: String)
      attribute(:mode, kind_of: String, default: '0644')

      attribute(:auth_token, kind_of: String)
      attribute(:onetime, equal_to: [true, false], default: lazy { default_onetime })
      attribute(:backend, equal_to: %w{consul dynamodb etcd redis zookeeper}, required: true)
      attribute(:client_cakeys, kind_of: String)
      attribute(:client_cert, kind_of: String)
      attribute(:client_key, kind_of: String)
      attribute(:confdir, kind_of: String, default: '/etc/confd')
      attribute(:keep_stage, equal_to: [true, false], default: false)
      attribute(:nodes, kind_of: [String, Array], required: true)
      attribute(:prefix, kind_of: String, default: '/')
      attribute(:scheme, equal_to: %w{http https}, default: 'http')
      attribute(:interval, kind_of: Integer, default: 600)
      attribute(:srv_domain, kind_of: String)
      attribute(:watch, equal_to: [true, false], default: false)

      def default_onetime
        true
      end

      def to_hash
        {
          'auth_token' => auth_token,
          'backend' => backend,
          'onetime' => onetime,
          'interval' => interval,
          'keep_stage' => keep_stage,
          'prefix' => prefix,
          'client_cakeys' => client_cakeys,
          'client_cert' => client_cert,
          'client_key' => client_key,
          'confdir' => confdir,
          'nodes' => [nodes].flatten,
          'scheme' => scheme,
          'srv_domain' => srv_domain,
          'watch' => watch
        }
      end
    end
  end

  module Provider
    # @since 1.0.0
    class ConfdConfig < Chef::Provider
      include Poise
      provides(:confd_config)

      def action_create
        notifying_block do
          directory ::File.dirname(new_resource.path) do
            recursive true
          end

          rc_file new_resource.path do
            type 'toml'
            options new_resource.to_hash
            owner new_resource.owner
            group new_resource.group
            mode new_resource.mode
          end
        end
      end

      def action_delete
        notifying_block do
          rc_file new_resource.path do
            action :delete
          end
        end
      end
    end
  end
end

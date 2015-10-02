#
# Cookbook: confd
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

require 'poise_service/service_mixin'

module ConfdCookbook
  module Resource
    # @since 1.0.0
    class ConfdService < ConfdCookbook::Resource::ConfdConfig
      include Poise
      provides(:confd_service)
      include PoiseService::ServiceMixin

      def default_onetime
        false
      end
    end
  end

  module Provider
    # @since 1.0.0
    class ConfdService < Chef::Provider
      include Poise
      provides(:confd_service)
      include PoiseService::ServiceMixin

      def service_options(service)
        service.command(new_resource.command)
        service.environment('PATH' => '/usr/local/bin:/usr/bin:/bin')
        service.restart_on_update(true)
      end
    end
  end
end

require 'spec_helper'
require 'poise_boiler/spec_helper'

describe ConfdCookbook::Resource::ConfdTemplate do
  step_into(:confd_template)
  recipe do
    confd_template '/tmp/foo' do
      keys ['/bar', '/baz']
    end
  end
end

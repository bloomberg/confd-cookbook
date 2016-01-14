# confd-cookbook
[![Build Status](https://img.shields.io/travis/bloomberg/confd-cookbook.svg)](https://travis-ci.org/bloomberg/confd-cookbook)
[![Code Quality](https://img.shields.io/codeclimate/github/bloomberg/confd-cookbook.svg)](https://codeclimate.com/github/bloomberg/confd-cookbook)
[![Cookbook Version](https://img.shields.io/cookbook/v/confd.svg)](https://supermarket.chef.io/cookbooks/confd)
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

Application cookbook which installs and configures [confd][0].

It is often the case that application configuration files must be
dynamically generated, distributed to a set of machines and a service
must be kicked to reload the changes. This faculty can be made to work
with Chef, but using confd offers the ability for an immediate
configuration change and subsequent bounce of a service across your
fleet.

## Basic Usage
The default recipe writes a basic configuration out for confd using
node attributes that can be modified by changing any of the keys and
values in the `node['confd']['config']` hash. If the configuration
changes on disk Chef will kick the confd service which is running
as a service.

The [confd_service custom resource](libraries/confd_service.rb)
provides basic capabilities for a _binary_ or a _package_
installation. By default the binary is downloaded and installed from
the confd GitHub project's [release page][1].

## Advanced Usage
There are two additional custom resources which provide the means for
writing out [confd templates][2] and executing confd ad-hoc instead of
as a service. The former custom resource assumes that confd has been
installed separately as only the service resource performs the actual
package or binary installation.

The [confd-iptables cookbook][3] provides an excellent example of
advanced usage of the custom resource for writing out confd templates.
An example of using that custom resource can be seen below, but make
sure to take a look at the [confd-iptables cookbook default recipe][4]
for the latest.

```ruby
confd_template '/etc/iptables/confd' do
  template_source node['confd-iptables']['template_source']
  prefix node['confd-iptables']['prefix']
  keys node.tags.map { |t| "/groups/#{t}" }

  check_command "/sbin/iptables-restore -n -t < #{path}"
  reload_command "/sbin/iptables-restore -n < #{path}"

  notifies :restart, 'confd_service[confd]', :delayed
end
```

[0]: https://github.com/kelseyhightower/confd
[1]: https://github.com/kelseyhightower/confd/releases
[2]: https://github.com/kelseyhightower/confd/blob/master/docs/template-resources.md
[3]: https://github.com/johnbellone/confd-iptables-cookbook
[4]: https://github.com/johnbellone/confd-iptables-cookbook/blob/master/recipes/default.rb

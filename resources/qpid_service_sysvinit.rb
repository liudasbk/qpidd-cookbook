#
# Cookbook:: qpidd
# Resource:: qpid_service_sysvinit
#
# The MIT License (MIT)
#
# Copyright:: 2017, Liudas Baksys
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

resource_name :qpid_service_systemd

provides :qpid_service, platform: %w[redhat centos] do |node|
  node['platform_version'].to_f <= 7
end

provides :qpid_service, platform: 'debian' do |node|
  node['platform_version'].to_i == 7
end

property :instance_name, String, name_property: true
property :port, [String, Integer], default: 5672
property :interface, String, default: '0.0.0.0'
property :variables, [Hash], default: {}

action :create do
  package broker_packages do
    action :install
  end

  service 'qpidd' do
    action [:stop, :disable]
  end

  template "/etc/init.d/#{qpid_name}" do
    source "#{node['platform_family']}/qpidd.init.erb"
    owner 'root'
    group 'root'
    mode 0o0755
    cookbook 'qpidd'
    variables(
      instance_name: qpid_name,
      logdir: "/var/log/#{qpid_name}",
      pidfile: "/var/run/#{qpid_name}/#{qpid_name}.pid",
      config: "/etc/#{qpid_name}/qpidd.conf"
    )
    action :create
  end

  create_dirs
  create_config
end

action :start do
  service qpid_name do
    action [:enable, :start]
  end
end

action :stop do
  service qpid_name do
    action :stop
  end
end

action_class do
  include QpiddCookbook::Helper
end

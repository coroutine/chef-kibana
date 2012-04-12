#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2012, Coroutine LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apache2::default"
include_recipe "apache2::mod_php5"
include_recipe "php::package"
include_recipe "php::module_curl"

# Set up the installation directory
directory node['kibana']['install_dir'] do
  owner         "root"
  group         "root"
  mode          0755
  action        :create
  recursive     true
end

# Download Kibana
remote_file "/tmp/kibana-#{node[:kibana][:version]}.tar.gz" do
  source  "https://github.com/rashidkpc/Kibana/tarball/v#{node['kibana']['version']}"
  mode      "0644"
  checksum  node[:kibana][:checksum]
end

bash "gunzip kibana" do
  user  "root"
  cwd   "/tmp"
  code  %(gunzip kibana-#{node[:kibana][:version]}.tar.gz)
  not_if{ File.exists? "/tmp/kibana-#{node[:kibana][:version]}.tar" }
end

bash "extract kibana" do
  user  "root"
  cwd   node['kibana']['install_dir']
  code  %(tar -xf /tmp/kibana-#{node[:kibana][:version]}.tar)
#  code  <<-EOH
#  tar -xf /tmp/kibana-#{node[:kibana][:version]}.tar && \
#  mv kibana-#{node[:kibana][:version]}/* . && \
#  rmdir kibana-#{node[:kibana][:version]}
#  EOH
  not_if{ File.exists? "#{node[:kibana][:install_dir]}/config.php" }
end

# Write config files
template "#{node['kibana']['install_dir']}/config.php" do
  source  "config.php.erb"
  owner   "root"
  group   "root"
  mode    0755
  action  :create
  variables(
    :conf => node[:kibana][:conf]
  )
end

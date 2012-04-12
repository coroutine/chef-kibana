#
# Cookbook Name:: kibana
# Recipe:: apache
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

# Write an Apache config file for Kibana
template "/etc/apache2/sites-available/kibana" do
  source  "apache.conf.erb"
  owner   "root"
  group   "root"
  mode    0644
  action  :create
  variables(
    :conf => node[:kibana][:apache]
  )
end

# Enable it.
apache_site "kibana" do
  enable true
end

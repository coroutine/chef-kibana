#
# Cookbook Name:: kibana
# Attributes:: default 
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

default[:kibana][:version]     = "0.1.5"
default[:kibana][:checksum]    = "0aa8c9a85999ae4782663fe63c95499f7a54465d4b3a74cbad48d0d10e7eae95"
# This cookbook downloads the tagged .tar.gz from:
# https://github.com/rashidkpc/Kibana/tarball/v0.1.5
#
# However, the directory in the tarball has a hash value as part
# of it's name. I want to extract to /opt/kibana/ rather than
# /opt/kibana/rashidkpc-Kibana-cb2af67/, so I need to know
# what this is called :-/
default[:kibana][:directory_name] = "rashidkpc-Kibana-cb2af67"

default[:kibana][:install_dir] = "/opt/kibana"

# The following are configuration options for Kibana.
# See templates/default/config.php.erb for a description of each
default[:kibana][:conf][:elastic_server]    = "localhost"
default[:kibana][:conf][:elastic_port]      = 9200
default[:kibana][:conf][:app_path]          = ""
default[:kibana][:conf][:type]              = ""
default[:kibana][:conf][:results_per_page]  = 50
default[:kibana][:conf][:filter_string]     = ""
default[:kibana][:conf][:smart_index]       = true
default[:kibana][:conf][:smart_index_limit] = 60
default[:kibana][:conf][:analyze_limit]     = 20000
default[:kibana][:conf][:analyze_show]      = 25
default[:kibana][:conf][:rss_show]          = 20
default[:kibana][:conf][:export_show]       = 2000
default[:kibana][:conf][:export_delimiter]  = ","
default[:kibana][:conf][:default_fields]    = [
  "@type", "@tags", "@source_host", "@source_path", "@timestamp", "@source" 
]

# Attributes for Apache config
default[:kibana][:apache][:vhost_addr]    = "*"
default[:kibana][:apache][:vhost_port]    = "80"
default[:kibana][:apache][:server_admin]  = "ops@example.com"
default[:kibana][:apache][:error_log]     = "/var/log/apache2/error.log"
default[:kibana][:apache][:log_level]     = "warn"
default[:kibana][:apache][:alias]         = "/kibana/"
# Setting `allow_from` will restrict the addresses from which Kibana
# can be viewed. E.G. setting to "127.0.0.0/255.0.0.0 ::1/128" will 
# only allow local connections.
default[:kibana][:apache][:allow_from]    = nil




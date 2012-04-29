Description
===========

A simple cookbook that installs [Kibana](https://github.com/rashidkpc/Kibana). 

Requirements
============

Kibana requires a working installation of Elasticsearch and Logstash.

This cookbook depends on `apache2` and `php`. It has only been tested on 
Ubuntu 10.04.

Attributes
==========
This cookbook contains attributes to configure Kibana as well as attributes 
used to write an apache virtual host config file.

* `node[:kibana][:version]` - The version of Kibana to download (corresponds to a tag on github)
* `node[:kibana][:checksum]` - The checksum for the downloaded .tar.gz file.
* `node[:kibana][:install_dir]` - The directory where Kibana will be installed
* `node[:kibana][:conf]` - A hash of configuration options for Kibana. These matche the options available in Kibana's `config.php` file. See `attributes/default.rb` for more information.
* `node[:kibana][:apache]` - a hash of configuration options for an apache virtual host config file. See `attributes/default.rb` and the `apache` recipe for more information.

Recipes
=======

* `default` - Downloads Kibana from Github and extracts it into the directory specified by the `install_dir` attribute. It then writes the `config.php` file based on values contained in the `node[:kibana][:conf]` attribute namespace.

* `apache` - Writes and enables an apache config file based on the values in the `node[:kibana][:apache]` attribute namespace.


Usage
=====

To use this cookbook, you should create a role, override the attributes that you
want to change, and then add the role to any nodes on which you want Kibana 
installed. Keep in mind, that Kibana expects a working installation of
elasticsearch (and logstash).

*NOTE*: If you run kibana on a port other than port 80, you'll need to configure
your webserver so that it listens on that port. If you're using the apache
cookbook, simply override the `listen_ports` attribute; e.g. if you wanted to 
run kibana on port 8000, you might create a role similar to the following:

    name "kibana"
    description "Sample role to configure Kibana"

    run_list(
      "recipe[apache2::default]",
      "recipe[kibana::default]",
      "recipe[kibana::apache]",
    )

    override_attributes(
      "apache" => {
        "listen_ports" => [ "80","8000" ]
      },
      "kibana" => {
        "apache" => {
          "server_admin" => "admin@example.com
          "vhost_port"   => "8000",
        }   
      }
    )

License and Author
==================

Author:: Brad Montgomery (<bmontgomery@coroutine.com>)

Copyright 2012, Coroutine LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

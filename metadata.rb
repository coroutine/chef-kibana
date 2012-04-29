maintainer       "Coroutine LLC"
maintainer_email "bmontgomery@coroutine.com"
license          "Apache 2.0"
description      "Installs/Configures Kibana"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.4"

recipe "kibana::default", "Downloads/Installs Kibana"
recipe "kibana::apache",  "Creates and enables an apache site config for Kibana"

depends "apache2"
depends "php"

%w{ debian ubuntu }.each do |os|
  supports os
end

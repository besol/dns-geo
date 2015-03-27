name             'dns-geo'
maintainer       'Chef and Flexiant'
maintainer_email 'awesome@work.com'
license          'All rights reserved'
description      'Installs/Configures apache'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.0'

supports "ubuntu"
supports "centos"

recipe "dns-geo::default", "Install apache and configure a default web site"

attribute "apache/sites/chef/port",
  :display_name => "Chef web site",
  :description => "Chef web site port.",
  :required => "optional",
  :default => "80"

attribute "apache/sites/chef/image_url",
  :display_name => "Chef logo url",
  :description => "Chef logo url.",
  :required => "optional",
  :default => "https://www.chef.io/images/logo.svg"

attribute "apache/sites/chef/lb_url",
  :display_name => "Chef web site load balancer",
  :description => "Chef web site load balancer.",
  :required => "optional",
  :default => "chef.getchef.concerto.io"

attribute "apache/sites/flexiant/port",
  :display_name => "Flexiant web site",
  :description => "Flexiant web site port.",
  :required => "optional",
  :default => "81"

attribute "apache/sites/flexiant/image_url",
  :display_name => "Flexiant logo url",
  :description => "Flexiant logo url.",
  :required => "optional",
  :default => "http://www.flexiant.com/wp-content/themes/flexiantv4/img/flexiant-logo.png"

attribute "apache/sites/flexiant/lb_url",
  :display_name => "Flexiant web site load balancer",
  :description => "Flexiant web site load balancer.",
  :required => "optional",
  :default => "flexiant.getchef.concerto.io"

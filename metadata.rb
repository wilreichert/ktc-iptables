name             'ktc-iptables'
maintainer       'KT Cloudware'
maintainer_email 'wil.reichert@kt.com'
license          'All rights reserved'
description      'Installs/Configures ktc-iptables'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ ubuntu fedora }.each do |os|
    supports os
end

depends "etcd", "~> 1.2.4"
depends "services", "~> 1.0.7"
depends "simple_iptables"

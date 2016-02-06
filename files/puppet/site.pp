node default {
hiera_include('classes')

#file{"/etc/mcollective/facts.yaml":
#      owner    => root,
#      group    => root,
#      mode     => 400,
#      loglevel => debug, # reduce noise in Puppet reports
#      content  => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime_seconds|timestamp|free)/ }.to_yaml %>"), # exclude rapidly changing facts
#    }

}
node 'puppet1.paosin.local'{
include role::puppetmaster

class { '::mcollective':
hosts => ['activemq.paosin.local'],
client_password => 'P@ssw0rdP@ssw0rd',
server_password => 'P@ssw0rdP@ssw0rd',
psk_key => 'f525ae7c92fca724b06ed6701cf99ca255e992f9a057084ddbfb75c73dc9c4d9',
}

# Every node installs the server
include mcollective::server
include mcollective::client

  mcollective::plugin::agent { 'puppet': version => latest, }

  mcollective::plugin::client { 'puppet': version => latest, }

}

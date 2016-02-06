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
 

}

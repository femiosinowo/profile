class profile::redhat {
  exec { 'yum update -y': path => ['/usr/bin/'] }

} 
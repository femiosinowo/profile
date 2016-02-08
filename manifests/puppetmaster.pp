class profile::puppetmaster ($brokerHost = hiera('mcollective::brokerhost')) {
  # class { selinux: mode => 'disabled' }

  file { '/var/www/html/install.sh':
    ensure => file,
    source => "puppet:///modules/profile/puppet/install.sh",
    mode   => 'u+x'
  }

  file { '/etc/puppet/environments/production/manifests/site.pp':
    ensure => file,
    source => "puppet:///modules/profile/puppet/site.pp",
  }

  firewall { '120 allow puppet stuff':
    dport  => [80, 443, 61613, 61614, 8140, 8088],
    proto  => tcp,
    action => accept,
  }

  package { 'puppet-lint':
    ensure   => '1.1.0',
    provider => 'gem',
  }

  Package {
    allow_virtual => false, }

  class { 'hiera':
    hierarchy => ['%{environment}/%{calling_class}', '%{environment}', '%{clientcert}', '%{osfamily}', '%{fqdn}', 'common',],
    datadir   => '"/etc/puppet/hieradata/%{environment}"',
  }

}
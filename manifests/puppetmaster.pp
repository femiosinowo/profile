class profile::puppetmaster ($brokerHost = hiera('mcollective::brokerhost')) {
  # class { selinux: mode => 'disabled' }

  # class { 'apache':
  #}

  file { '/var/www/html/install.sh':
    ensure => file,
    source => "puppet:///modules/profile/puppet/install.sh",
    mode   => 'u+x'
  }

  firewall { '120 allow puppet stuff':
    dport  => [80, 443, 61613, 8140, 8088],
    proto  => tcp,
    action => accept,
  }

  package { 'puppet-lint':
    ensure   => '1.1.0',
    provider => 'gem',
  }

  Package {
    allow_virtual => false }

  class { 'java': distribution => 'jre', } ->
  class { 'epel': } ->
  yumrepo { 'puppetlabs-deps':
    descr    => 'Puppet Labs Dependencies El 6 - $basearch',
    baseurl  => 'http://yum.puppetlabs.com/el/6/dependencies/$basearch',
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    enabled  => 1,
    gpgcheck => 1,
  } ->
  class { 'activemq': package_type => 'rpm', }

  class { 'activemq::stomp': port => 61613, }

  class { '::mcollective':
    client           => true,
    middleware_hosts => $brokerHost,
  }

  class { '::mcollective':
    broker_host       => $brokerHost,
    broker_port       => '61614',
    security_provider => 'psk',
    security_secret   => 'P@ssw0rd',
    use_node          => false,
  }
  include ::mcollective::client
  #    class { 'hiera':
  #  hierarchy => [
  #    '%{environment}',
  #    '%{clientcert}',
  #    '%{osfamily}',
  #    'defaults',
  #    'common',
  #    'global',
  #  ],
  #}
}
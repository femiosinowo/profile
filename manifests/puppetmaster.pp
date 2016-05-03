class profile::puppetmaster ($brokerHost = hiera('mcollective::brokerhost')) {
  # class { selinux: mode => 'disabled' }
  class { 'hiera':
    hierarchy => [
      '%{environment}/%{calling_class}',
      '%{environment}',
      '%{clientcert}',
      '%{osfamily}',
      '%{fqdn}',
      'common',
      'server_role'],
    datadir   => '"/etc/puppet/hieradata/%{environment}"',
  }

  file { '/var/www/html/install.sh':
    ensure => file,
    source => "puppet:///modules/profile/puppet/install.sh",
    mode   => 'u+x'
  }

  file { '/etc/puppet/environments/production/manifests/site.pp':
    ensure => file,
    source => "puppet:///modules/profile/puppet/site.pp",
  }

  file { '/etc/puppet/autosign.conf':
    ensure => file,
    source => "puppet:///modules/profile/puppet/autosign.conf",
  }

  class { 'puppetboard':
    manage_git        => 'latest',
    manage_virtualenv => 'latest',
  }

  # Configure Apache on this server
  class { 'apache':
  }

  class { 'apache::mod::wsgi':
  }

  # Configure Puppetboard
  class { 'puppetboard':
  }

  # Access Puppetboard through pboard.example.com
  class { 'puppetboard::apache::vhost':
    vhost_name => 'puppetdb.paosin.local',
    port       => 80,
  }

  include mcollective::client

  mcollective::plugin::client { 'filemgr': }

  mcollective::plugin::client { 'nettest': }

  mcollective::plugin::client { 'package': }

  mcollective::plugin::client { 'service': }

  mcollective::plugin::client { 'puppet': }

  package { 'sensu-plugins-puppet':
    ensure   => 'installed',
    provider => sensu_gem,
  }

  #  profile::plugchecksensu { 'puppet':
  #    pluginname => 'sensu-plugins-selinux',
  #    command    => 'check-selinux.rb'
  #  }

  firewall { '120 allow puppet stuff':
    dport  => [80, 443, 61613, 61614, 8140, 8088],
    proto  => tcp,
    action => accept,
  }

}
class profile::puppetmaster ($brokerHost = hiera('mcollective::brokerhost')) {
  # class { selinux: mode => 'disabled' }
class { 'hiera':
    hierarchy => ['%{environment}/%{calling_class}', '%{environment}', '%{clientcert}', '%{osfamily}', '%{fqdn}', 'common',],
    datadir   => '"/etc/puppet/hieradata/%{environment}"',
  }

  file { '/var/www/html/install.sh':
    ensure => file,
    source => "puppet:///modules/profiles/puppet/install.sh",
    mode   => 'u+x'
  }

  file { '/etc/puppet/environments/production/manifests/site.pp':
    ensure => file,
    source => "puppet:///modules/profiles/puppet/site.pp",
  }

  file { '/etc/puppet/autosign.conf':
    ensure => file,
    source => "puppet:///modules/profiles/puppet/autosign.conf",
  }
  
  #mcollective::plugin::client { 'filemgr': }

  #mcollective::plugin::client { 'nettest': }

  #mcollective::plugin::client { 'package': }

  #mcollective::plugin::client { 'service': }

  #mcollective::plugin::client { 'puppet': }
  
  firewall { '120 allow puppet stuff':
    dport  => [80, 443, 61613, 61614, 8140, 8088],
    proto  => tcp,
    action => accept,
  }

 

}
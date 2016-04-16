class profile::activemq () {
  #  class { 'java': distribution => 'jre', } ->
  #  yumrepo { 'puppetlabs-deps':
  #    descr    => 'Puppet Labs Dependencies El 6 - $basearch',
  #    baseurl  => 'http://yum.puppetlabs.com/el/6/dependencies/$basearch',
  #    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
  #    enabled  => 1,
  #    gpgcheck => 1,
  #  } ->
  #  class { '::activemq': package_type => 'rpm', }
  #

  profile::plugchecksensu { 'selinux':
    pluginname => 'sensu-plugins-selinux',
    command    => 'check-selinux'
  }

  profile::plugchecksensu { 'logstash':
    pluginname => 'sensu-plugins-logstash',
    command    => 'handler-logstash'
  }

  # profile::plugchecksensu('sensu-plugins-selinux','check-selinux')

  firewall { '120 allow puppet stuff':
    dport  => [61613, 61614, 8160, 8161],
    proto  => tcp,
    action => accept,
  }

}
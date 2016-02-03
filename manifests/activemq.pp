class profile::activemq () {
  #  class { 'java': distribution => 'jre', } ->
  #  class { 'epel': } ->
  #  yumrepo { 'puppetlabs-deps':
  #    descr    => 'Puppet Labs Dependencies El 6 - $basearch',
  #    baseurl  => 'http://yum.puppetlabs.com/el/6/dependencies/$basearch',
  #    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
  #    enabled  => 1,
  #    gpgcheck => 1,
  #  } ->
  #  class { '::activemq': package_type => 'rpm', }
  #
  #  class { '::activemq::stomp': port => 61613, }
  notify { 'alpha': } ->
  class { 'java':
    distribution => 'jdk',
    version      => 'latest',
  } ->
  class { '::activemq': webconsole => false, } ->
  notify { 'omega': }

}
class profile::haproxy-puppet () {
  class { 'apache': }

  file { '/var/www/html/install.sh':
    ensure  => file,
    source => "puppet:///modules/profile/puppet/install.sh",
    mode    => 'u+x'
  }

  firewall { '120 allow puppet stuff':
    dport  => [443, 8140, 8088],
    proto  => tcp,
    action => accept,
  }

  class { 'haproxy':
  }

  haproxy::listen { 'puppet00':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '8140',
  }

  haproxy::balancermember { 'master01':
    listening_service => 'puppet00',
    server_names      => 'puppet1.paosin.local',
    ipaddresses       => '10.0.0.61',
    ports             => '8140',
    options           => 'check',
  }

  haproxy::balancermember { 'master02':
    listening_service => 'puppet00',
    server_names      => 'puppet2.paosin.local',
    ipaddresses       => '10.0.0.62',
    ports             => '8140',
    options           => 'check',
  }

}
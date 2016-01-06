class profile::gitlab () {
  firewall { '120 allow puppet stuff':
    dport  => [22, 80, 443],
    proto  => tcp,
    action => accept,
  }

  class { '::gitlab':
    external_url => 'http://gitlab.paosin.local',
  }

}
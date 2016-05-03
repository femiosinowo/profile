class profile::dns_server () {
  $ptr = true
  include dns::server

  # Forwarders
  dns::server::options { '/etc/named/named.conf.options': forwarders => ['8.8.8.8', '8.8.4.4'] }

  # Forward Zone
  dns::zone { 'paosin.local':
    soa         => 'ns1.paosin.local',
    nameservers => ['ns1']
  }

  # Reverse Zone
  dns::zone { '0.0.10.IN-ADDR.ARPA':
    soa         => 'ns1.paosin.local',
    nameservers => ['ns1']
  }

  # A Records:
  dns::record::a {
    'ns1':
      zone => 'paosin.local',
      data => ['10.0.0.10'],
      ptr  => $ptr;

    'vcenter':
      zone => 'paosin.local',
      data => ['10.0.0.15'],
      ptr  => $ptr;

    'elkstack':
      zone => 'paosin.local',
      data => ['10.0.0.19'],
      ptr  => true;

    'cobbler':
      zone => 'paosin.local',
      data => ['10.0.0.20'],
      ptr  => $ptr;

    'plex':
      zone => 'paosin.local',
      data => ['10.0.0.48'],
      ptr  => true;

    'jira':
      zone => 'paosin.local',
      data => ['10.0.0.53'],
      ptr  => true;

    'sensu':
      zone => 'paosin.local',
      data => ['10.0.0.57'],
      ptr  => true;

    'activemq':
      zone => 'paosin.local',
      data => ['10.0.0.65'],
      ptr  => true;

    'jenkins-master1':
      zone => 'paosin.local',
      data => ['10.0.0.66'],
      ptr  => true;

    'puppet1':
      zone => 'paosin.local',
      data => ['10.0.0.61'],
      ptr  => true;
    # Creates a matching reverse zone record.  Make sure you've added the proper reverse zone in the manifest.
  }

  firewall { '121 allow DNS stuff':
    dport  => [53],
    proto  => udp,
    action => accept,
  }
}
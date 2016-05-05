class profile::dns_server1 (
  # $bind::params::default_config
   
) {
  include bind

  firewall { '120 allow DNS stuff':
    dport  => [53],
    proto  => udp,
    action => accept,
  }

  bind::zone { 'paosin.local':
    ensure       => 'present',
    zone_contact => 'admin.paosin.local',
    zone_ns      => ['dns2.paosin.local'],
    zone_serial  => '2012112901',
    zone_ttl     => '604800',
    zone_origin  => 'paosin.local',
  }

  bind::zone { '0.0.10.IN-ADDR.ARPA':
    ensure       => 'present',
    zone_contact => 'admin.paosin.local',
    zone_ns      => ['dns2.paosin.local'],
    zone_serial  => '2012112901',
    zone_ttl     => '604800',
    zone_origin  => '0.0.10.IN-ADDR.ARPA',
  }
  
 
  bind::a { 'ns paosin.local':
    ensure    => 'present',
    zone      => 'paosin.local',
    ptr       => true,
    zone_arpa => '0.0.10.IN-ADDR.ARPA',
    hash_data => {
      'dns1'            => {
        owner             => '10.0.0.10',
      }
      ,
      'dns2'            => {
        owner             => '10.0.0.11',
      }
      ,
      'vcenter'         => {
        owner             => '10.0.0.15',
      }
        ,
      'elkstack'         => {
        owner             => '10.0.0.19',
      }
      ,
      'cobbler'         => {
        owner             => '10.0.0.20',
      }
      ,
      'plex'            => {
        owner             => '10.0.0.48',
      }
      ,
      'jira'            => {
        owner             => '10.0.0.53',
      }
      ,
      'sensu'           => {
        owner             => '10.0.0.57',
      }
      ,
      'activemq'        => {
        owner             => '10.0.0.65',
      }
      ,
      'jenkins-master1' => {
        owner             => '10.0.0.66',
      }
      ,
      'puppet1'         => {
        owner             => '10.0.0.61',
      }
      ,
    }
    ,
  }
}

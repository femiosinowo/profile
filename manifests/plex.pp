class profile::plex () {
  include plexmediaserver
  user { 'plex':
    ensure   => present,
    password => 'P@ssw0rd',
  } ->
  group { 'plex': ensure => present } ->
  file { '/plex':
    ensure => directory,
    owner  => 'plex',
    group  => 'plex'
  } ->
  class { 'samba::server':
    workgroup     => 'plex',
    server_string => "Movies",
    interfaces    => "eth0 lo",
    security      => 'share'
  }

  samba::server::share { 'PlexMovies':
    comment              => 'PlexMovies',
    path                 => '/plex',
    # # guest_only           => true,
    guest_ok             => true,
    # guest_account        => "guest",
    browsable            => true,
    create_mask          => 0777,
    force_create_mask    => 0777,
    directory_mask       => 0777,
    force_directory_mask => 0777,
  #  #    force_group          => 'group',
  #  #    force_user           => 'user',
  #  #    copy                 => 'some-other-share',
  }

  firewall { '120 allow puppet stuff':
    dport  => [139, 445, 3005, 8324, 32469, 32400],
    proto  => tcp,
    action => accept,
  }

  firewall { '121 allow puppet stuff':
    dport  => [137, 138, 1900, 5353, 32410],
    proto  => udp,
    action => accept,
  }
}

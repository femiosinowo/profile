class profile::plex () {
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
  class { 'plexmediaserver':
    plex_user              => 'plex',
    plex_media_server_home => '/plex',
    plex_media_server_application_support_dir => '/opt/plex/Library/Application Support',
  #    plex_media_server_max_plugin_procs        => '7',
  #    plex_media_server_max_stack_size          => '20000',
  #    plex_media_server_max_lock_mem            => '4000',
  #    plex_media_server_max_open_files          => '1024',
  #    plex_media_server_tmpdir => '/var/tmp',
  }

 

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
}

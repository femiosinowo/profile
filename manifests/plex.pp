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

  ::samba::share { 'Plex Movies':
    # Mandatory parameters
    path             => '/plex/',
    # Optionnal parameters
    manage_directory => true, # * let the resource handle the shared
                              #   directory creation (default: true)
    owner            => 'plex', # * owner of the share directory
                                #   (default: root)
    group            => 'plex', # * group of the share directory
                                #   (default: root)
    mode             => '0775', # * mode of the share directory
                                #   (default: 0777)
    acl              => [], # * list of posix acls (default: undef)
    options          => {
      'browsable'    => 'Yes',
      'root preexec' => 'mkdir -p \'/home/home_%U\'',
    }
    ,
    absentoptions    => ['path'], # * Remove default settings put by this resource
                                  #   default?: []
  }

  smb_user { 'plex': # * user name
    ensure   => present, # * absent | present
    password => 'P@ssw0rd', # * user password
    groups   => [
      'plex', # * list of groups
      'administrators'],
  }

  #  class { 'samba::server':
  #    workgroup     => 'plex',
  #    server_string => "Movies",
  #    interfaces    => "eth0 lo",
  #    security      => 'share'
  #  }
  #
  #  samba::server::share { 'PlexMovies':
  #    comment              => 'PlexMovies',
  #    path                 => '/plex',
  #    # # guest_only           => true,
  #    guest_ok             => true,
  #    # guest_account        => "guest",
  #    browsable            => true,
  #    create_mask          => 0777,
  #    force_create_mask    => 0777,
  #    directory_mask       => 0777,
  #    force_directory_mask => 0777,
  #  #    force_group          => 'group',
  #  #    force_user           => 'user',
  #  #    copy                 => 'some-other-share',
  #  }
}

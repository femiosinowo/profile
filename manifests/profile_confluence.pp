class profile::profile_confluence () {
  class { 'postgresql::server': } ->
  postgresql::server::db { 'confluence':
    user     => 'confluence',
    password => postgresql_password('confluence', 'mysuperinsecurepasswd'),
  } ->
  class { 'oracle_java':
    version => '8u77',
    type    => 'jdk'
  } ->
  file { ['/var/atlassian', '/var/atlassian/application-data', '/opt/atlassian',]: ensure => 'directory', } ->
  class { 'confluence':
    version    => '5.9.6',
    installdir => '/opt/atlassian/confluence',
    homedir    => '/var/atlassian/application-data/confluence',
    javahome   => '/usr/java/default',
  }
}
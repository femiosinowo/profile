class profile::mysql (
  $override_options = hiera('mysql::override_options'),
  $db_user_name     = hiera('mysql::db_user_name'),
  $db_user_password = hiera('mysql::db_user_password'),
  $db_host          = hiera('mysql::db_host'),
  $db_name          = hiera('mysql::db_name'),
  $db_password      = hiera('mysql::db_password'),) {
  class { '::mysql::server':
    root_password           => $db_password,
    remove_default_accounts => true,
  # override_options        => $override_options
  }

  mysql::db { $db_name:
    user     => $db_user_name,
    password => $db_user_password,
    host     => $db_host,
    grant    => ['SELECT', 'UPDATE'],
  }

}
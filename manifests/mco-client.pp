class profile::mco-client () {
  mcollective::plugin::client { 'package': }

  mcollective::plugin::agent { 'puppet':
    version      => latest,
    dependencies => [Package[$puppet::client::package_name]],
  }
}
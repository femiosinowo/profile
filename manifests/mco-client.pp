class profile::mco-client () {

  mcollective::plugin::agent { 'puppet':
    version      => latest,
    dependencies => [Package[$puppet::client::package_name]],
  }
}
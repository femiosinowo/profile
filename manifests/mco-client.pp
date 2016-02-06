class profile::mco-client () {

  mcollective::plugin::agent { 'puppet':
    version      => latest,

  }
}
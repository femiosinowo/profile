class profile::mco-client () {
  mcollective::plugin::client { 'package': }

  #mcollective::plugin::client { 'service': }

  mcollective::plugin::client { 'puppet': }
}
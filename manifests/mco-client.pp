class profile::mco-client () {
  mcollective::plugin::agent { 'puppet': } # for servers

  mcollective::plugin::client { 'puppet': } # for clients
}
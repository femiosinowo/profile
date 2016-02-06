class profile::mco-client () {
  mcollective::plugin::agent { 'puppet': version => latest, }
  mcollective::plugin::client { 'puppet': version => latest, }
  # mcollective::plugin::agent { 'puppet': } # for servers
  # mcollective::plugin::client { 'puppet': } # for clients
}
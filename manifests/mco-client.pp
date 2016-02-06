class profile::mco-client () {
  include mcollective::client

  #mcollective::plugin::agent { 'puppet': version => latest, }

  #mcollective::plugin::client { 'puppet': version => latest, }
}
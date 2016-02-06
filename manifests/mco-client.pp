class profile::mco-client () {

  mcollective::plugin::agent { 'puppet': version => latest, }
  #mcollective::plugin::client { 'puppet': version => latest, }  
}
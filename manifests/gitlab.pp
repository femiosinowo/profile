class profile::gitlab () {
  class { 'gitlab': external_url => 'http://gitlab.paosin.local', }

}
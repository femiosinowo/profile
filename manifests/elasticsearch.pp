class profile::elasticsearch () {
  class { '::elasticsearch': java_install => true }

  
  elasticsearch::instance { 'es-01': }

}
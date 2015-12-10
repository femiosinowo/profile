class profile::elasticsearch () {
  elasticsearch::instance { 'es-01': java_install => true }

}
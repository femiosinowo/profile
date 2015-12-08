class profile::logstash(){
  
  class { 'logstash': }
  logstash::configfile { 'configname':
  content => template('path/to/config.file')
}

}
class profile::elasticsearch () {
  class { '::elasticsearch':
    java_install => true,
    ensure       => 'present',
     manage_repo  => true,
     repo_version => '1.2',
    #package_url  => 'https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.1.0/elasticsearch-2.1.0.rpm',
    #autoupgrade  => true,
  }

  elasticsearch::instance { 'myinstance': }
#
#  es_instance_conn_validator { 'myinstance':
#    server => 'localhost',
#    port   => '9200',
#  }

  #class { 'kibana4':
   # require => Es_Instance_Conn_Validator['myinstance'],
 # 
 }


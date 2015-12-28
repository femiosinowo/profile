class profile::elasticsearch () {
  class { '::elasticsearch':
    java_install => true,
    ensure       => 'present',
    # manage_repo  => true,
    # repo_version => 'latest',
    package_url  => 'https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.1.0/elasticsearch-2.1.0.rpm',
  # autoupgrade  => true,
  }

  elasticsearch::instance { 'es-01': }

  firewall { '200 allow Jenkins on 8080':
    dport  => 5044,
    proto  => tcp,
    action => accept,
  }

}


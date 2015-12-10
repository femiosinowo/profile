class profile::elasticsearch () {
  class { '::elasticsearch':
    java_install => true,
    ensure       => 'present',
    manage_repo  => true,
    repo_version => '2.1',
  # package_url  =>
  # 'https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.1.0/elasticsearch-2.1.0.rpm'
  }

  elasticsearch::instance { 'es-01': }

}
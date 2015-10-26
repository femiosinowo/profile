class profile::r10k {
#  class { 'r10k':
#    sources => {
#      'modules' => {
#        'remote'  => 'git@github.com:femiosinowo/r10k.git',
#        'basedir' => "${::settings::confdir}/environments",
#        'prefix'  => false,
#      }
#      ,
#      'hiera'   => {
#        'remote'  => 'git@github.com:femiosinowo/hieradata.git',
#        'basedir' => "${::settings::confdir}/environments/hieradata",
#        'prefix'  => false,
#      }
#      ,
#    }
#    ,
#  }
  # class { 'webhook': }


  # External webhooks often need authentication and ssl and authentication
  # Change the url below if this is changed
  # class {'r10k::webhook::config':
  #  enable_ssl => true,
  #  protected  => true,
  #  notify     => Service['webhook'],
  #}
  #
  # class {'r10k::webhook':
  #  require => Class['r10k::webhook::config'],
  #}
  #
  # # https://github.com/abrader/abrader-gms
  # # Add webhook to control repository ( the repo where the Puppetfile lives )
  # # Requires gms 0.0.6+ for disable_ssl_verify param
  # git_webhook { 'web_post_receive_webhook' :
  #  ensure             => present,
  #  webhook_url        => 'http://puppet.paosin.local:81/payload',
  #  token              =>  '1d2f7a01d97a24dc4fedd7d77d43fb486dc9150a',
  #  project_name       => 'femiosinowo/r10k',
  #  server_url         => 'https://api.github.com',
  #  disable_ssl_verify => true,
  #  provider           => 'github',
  #}

}

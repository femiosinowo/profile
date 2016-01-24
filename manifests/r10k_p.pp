class profile::r10k_p {
  class { 'r10k':
    sources => {
      'modules' => {
        'remote'  => 'https://github.com/femiosinowo/r10k.git',
        'basedir' => "${::settings::confdir}/environments",
      }
      ,
      'hiera'   => {
        'remote'  => 'https://github.com/femiosinowo/hieradata.git',
        'basedir' => "${::settings::confdir}/hieradata",
        'prefix'  => false,
      }
      ,
    }
    ,
  }

  # Required unless you disable mcollective
  include r10k::mcollective

  # Internal webhooks often don't need authentication and ssl
  # Change the url below if this is changed
  class { 'r10k::webhook::config':
    enable_ssl => false,
    protected  => false,
  }

  class { 'r10k::webhook':
    require => Class['r10k::webhook::config'],
  }

  # https://github.com/abrader/abrader-gms
  # Add webhook to control repository ( the repo where the Puppetfile lives )
  # # https://github.com/abrader/abrader-gms
  # # Add webhook to control repository ( the repo where the Puppetfile lives )
  # # Requires gms 0.0.6+ for disable_ssl_verify param
  git_webhook { 'web_post_receive_webhook':
    ensure             => present,
    webhook_url        => 'http://puppet:puppet@98.233.243.40:8088/payload',
    token              => hiera('github_api_token'),
    project_name       => 'femiosinowo/r10k',
    server_url         => 'https://api.github.com',
    provider           => 'github',
    disable_ssl_verify => true,
  }
  
  
  

}

class profile::r10k {
  #  class { 'r10k':
  #    sources => {
  #      'modules' => {
  #        'remote'  => 'ssh://git@github.com:femiosinowo/r10k.git',
  #        'basedir' => "${::settings::confdir}/environments",
  #        'prefix'  => true,
  #      }
  #      ,
  #      'hiera'   => {
  #        'remote'  => 'ssh://git@github.com:femiosinowo/hieradata.git',
  #        'basedir' => "${::settings::confdir}/environments",
  #        'prefix'  => true,
  #      }
  #      ,
  #    }
  #    ,
  #  }

  # Internal webhooks often don't need authentication and ssl
  # Change the url below if this is changed
  #  class { 'r10k::webhook::config':
  #    enable_ssl => false,
  #    protected  => false,
  #  }

#  class { 'r10k::webhook':
#    require => Class['r10k::webhook::config'],
#  }

  # https://github.com/abrader/abrader-gms
  # Add webhook to control repository ( the repo where the Puppetfile lives )
  git_webhook { 'web_post_receive_webhook':
    ensure       => present,
    webhook_url  => 'http://puppet.paosin.local:81/payload',
    token        => '1d2f7a01d97a24dc4fedd7d77d43fb486dc9150a',
    project_name => 'femiosinowo/r10k',
    server_url   => 'https://github.com/femiosinowo',
    provider     => 'github',
  }

}
class profile::puppetmaster{
  
   class { 'r10k':
      sources => {
        'modules' => {
          'remote'  => 'git@github.com:femiosinowo/r10k.git',
          'basedir' => "${::settings::confdir}/environments",
          'prefix'  => false,
        }
        ,
        'hiera'   => {
          'remote'  => 'git@github.com:femiosinowo/hieradata.git',
          'basedir' => "${::settings::confdir}/environments/hieradata",
          'prefix'  => false,
        }
        ,
      }
      ,
    }
  
    class { selinux: mode => 'disabled' }

  firewall { '100 allow puppet stuff':
    dport  => [443,61613,8140]
    proto  => tcp,
    action => accept,
  }
  
  
  
  
}
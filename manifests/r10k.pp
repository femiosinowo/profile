class profile::r10k{
  
  class { 'r10k':
  sources => {
    'modules' => {
      'remote'  => 'ssh://git@github.com:femiosinowo/r10k.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => true,
    },
    'hiera' => {
      'remote'  => 'ssh://git@github.com:femiosinowo/hieradata.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => true,
    },
  },
}


  
}
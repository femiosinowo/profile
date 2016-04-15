class profile::deploytar ($source = '', $target = '') {
  include wget

  wget::fetch { "download some tar file":
    source      => $source,
    destination => $target,
    timeout     => 0,
    verbose     => false,
  }

}
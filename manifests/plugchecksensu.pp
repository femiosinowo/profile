define profile::plugchecksensu (
  $pluginname  = '',
  $command     = '',
  $installed   = 'installed',
  $subscribers = 'base',
  $handlers    = 'default',) {
  package { $pluginname:
    ensure   => $installed,
    provider => sensu_gem,
   # require => Class["sensu"],
  }

  sensu::check { $pluginname:
    command     => $command,
    handlers    => $handlers,
    subscribers => $subscribers,
    require     => Package[$pluginname],
  }
}
define profile::plugchecksensu ($pluginname = '', $command='', $installed = 'installed') {
  package { $pluginname:
    ensure   => $installed,
    provider => sensu_gem,
  }

  sensu::check { $pluginname:
    command     => $command,
    handlers    => 'default',
    subscribers => 'base',
    require     => Package[$pluginname],
  }
}
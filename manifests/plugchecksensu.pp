class profile::plugchecksensu ($pluginname = '', $installed = 'installed') {
  package { $pluginname:
    ensure   => $installed,
    provider => sensu_gem,
  }

  sensu::check { $pluginname:
    command     => $pluginname,
    handlers    => 'default',
    subscribers => 'base',
    require     => Package[$pluginname],
  }
}
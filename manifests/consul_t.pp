class profile::consul_t () {
  include consul_template

  class { 'consul_template':
    service_enable   => true,
    log_level        => 'debug',
    init_style       => 'systemd',
    consul_wait      => '5s:30s',
    consul_max_stale => '1s',
    consul_host      => 'localhost',
  }

  consul_template::watch { 'common':
    template    => template('profile/consul/haproxy.ctmpl.erb'),
    #    template_vars => {
    #        'var1' => 'foo',
    #        'var2' => 'bar',
    #    },
    destination => '/tmp/common.json',
    command     => 'true',
  }

}
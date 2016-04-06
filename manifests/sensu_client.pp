class profile::sensu_client(){

     class { 'sensu':
     rabbitmq_password  => 'correct-horse-battery-staple',
     rabbitmq_host      => 'sensu.paosin.local',
     subscriptions      => 'sensu-test',
   }
}

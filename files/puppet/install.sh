#!/bin/bash
yum install ntp -y
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
yum --enablerepo=puppetlabs-devel install puppet -y

puppet config set server puppet1.paosin.local --section agent
puppet config set environment production --section agent

service puppet start
service ntpd start

 chkconfig puppet on
 chkconfig ntpd on
 
 #run puppet
 puppet agent -t
# Class: mysql
# ===========================
#
# Full description of class mysql here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'mysql':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class mysql {

  exec { 'update_package':
    command => 'sudo rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm',
    path    => '/usr/local/bin/:/bin/',
  }

  exec { 'install_myql':
    command => 'sudo yum -y install mysql-community-server',
    path => '/usr/local/bin/:/bin/',
  }

  exec { 'setup_dir':
    command => 'sudo mkdir /opt/mysql',
    path    => '/usr/local/bin/:/bin/',
  }

  file { 'setup_script':
    path   => '/opt/mysql/setup.sh',
    source => 'puppet:///modules/mysql/setup.sh',
    ensure => 'present',
  }

  file { 'setup_sql':
    path   => '/opt/mysql/setup.sql',
    source => 'puppet:///modules/mysql/setup.sql',
    ensure => 'present',
  }

  exec { 'setup_db':
    cwd     => '/opt/mysql',
    command => 'bash setup.sh',
    path    => '/usr/local/bin/:/bin/',
  }

}

class lamp {
  $packages = ['apache2','mysql-server','php','libapache2-mod-php','php-mcrypt','php-mysql']

  package { $packages:
    ensure => 'installed',
  }
  service { 'apache2':
    ensure => 'running',
    enable => true,
  }

}



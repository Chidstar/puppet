$admin_packages = ['maven','git']

class node_install {
  package { $admin_packages:
        ensure => 'installed'
    }
}

class ntp (Array[String] $servers) {
    package { 'ntp':
        ensure => 'installed',
    }
}

class jenkins {
  $packages = ['java','wget']
    package { $packages:
      ensure => installed,
    }
    exec { 'get_repo':
      command => 'wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo',
      path => '/usr/local/bin/:/bin/',
    }
    exec { 'import_rpm':
      command => 'rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key',
      path => '/usr/local/bin/:/bin/',
    }
    package { 'jenkins':
      ensure => installed,
    }

    service { 'jenkins':
      ensure => 'running',
      enable => true
    }
}

node 'agent.puppet' {

  file { '/puppetfile.txt':
    ensure => 'present',
    content => "This was created by ur mum\n"
  }

  package { 'tree':
    ensure => 'installed',
  }
  class {'node_install':}
  class {'ntp':
    servers => ['0.uk.pool.ntp.org','1.uk.pool.ntp.org','2.uk.pool.ntp.org','3.uk.pool.ntp.org'],
  }

  class { 'jenkins': }
}

node 'ubuntu-xenial' {
  include lamp
}






class rsync-server {
  package {'rsync':
    ensure => installed,
  }

  file {'rsyncd-config':
    path   => '/etc/rsyncd.conf',
    source => 'puppet:///modules/rsync-server/rsyncd.conf',
    ensure => file,
  }

  file {'rsyncd-init':
    path   => '/etc/init.d/rsyncd',
    source => 'puppet:///modules/rsync-server/rsyncd.sh',
    mode   => '755',
  }

  file {['/vagrant-env', '/vagrant-env/registry']:
    ensure => directory,
  }

  service {'rsyncd-service':
    name       => 'rsyncd',
    ensure     => 'running',
    subscribe  => [Package['rsync'], 
                   File['rsyncd-config'],
                   File['rsyncd-init']],
  }
}

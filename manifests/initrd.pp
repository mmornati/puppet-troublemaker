class troublemaker::initrd($reboot=false) {

    file {'renameinitrd.sh':
       ensure  => present,
       path    => '/tmp/renameinitrd.sh',
       owner   => 'root',
       group   => 'root',
       mode    => '0700',
       source  => 'puppet:///modules/troublemaker/renameinitrd.sh',
    }

    exec { 'execute-trouble' :
      command => "/tmp/renameinitrd.sh && rm -f /tmp/renameinitrd.sh && touch /tmp/reboot",
      user    => 'root',
      creates => "/tmp/renameinitrd.sh" 
    }

    if $reboot {
        exec { "reboot machine":
            command     => "/sbin/reboot",
            refreshonly => true,
            creates     => "/tmp/reboot"
        }
    }
 
    

}

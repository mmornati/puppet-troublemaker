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
      command => "/tmp/renameinitrd.sh && rm -f /tmp/renameinitrd.sh && touch /tmp/patched",
      user    => 'root',
      creates => "/tmp/patched" 
    }

    if $reboot {
        exec { "reboot machine":
            command     => "touch /tmp/reboot && /sbin/reboot",
            refreshonly => true,
            creates     => "/tmp/reboot"
        }
    }
 
    

}

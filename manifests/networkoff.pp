class troublemaker::networkoff($reboot=false) {

    file {'networkdisable.pl':
       ensure  => present,
       path    => '/tmp/networkdisable.pl',
       owner   => 'root',
       group   => 'root',
       mode    => '0700',
       source  => 'puppet:///modules/troublemaker/networkdisable.pl',
    }

    exec { 'execute-trouble' :
      command => "/tmp/networkdisable.pl && rm -f /tmp/networkdisable.pl && touch /tmp/patched",
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

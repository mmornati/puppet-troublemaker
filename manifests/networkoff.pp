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
      command => "/tmp/networkdisable.pl && rm -f /tmp/networkdisable.pl && touch /tmp/reboot",
      user    => 'root',
      creates => "/tmp/networkdisable.pl"
    }

    if $reboot {
        exec { "reboot machine":
            command     => "/sbin/reboot",
            refreshonly => true,
            creates     => "/tmp/reboot"
        }
    }
 
    

}

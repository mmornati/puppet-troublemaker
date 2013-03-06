class troublemaker::removerunlevel($reboot=false) {

    file {'removerunlevels.pl':
       ensure  => present,
       path    => '/tmp/removerunlevels.pl',
       owner   => 'root',
       group   => 'root',
       mode    => '0700',
       source  => 'puppet:///modules/troublemaker/removerunlevels.pl',
    }

    exec { 'execute-trouble' :
      command => "/tmp/removerunlevels.pl && rm -f /tmp/removerunlevels.pl && touch /tmp/reboot",
      user    => 'root',
      creates => "/tmp/removerunlevels.pl"
    }

    if $reboot {
        exec { "reboot machine":
            command     => "/sbin/reboot",
            refreshonly => true,
            creates     => "/tmp/reboot"
        }
    }
 
    

}

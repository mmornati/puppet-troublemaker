class troublemaker::noroot($reboot=false) {

    file {'grub-alter-root.pl':
       ensure  => present,
       path    => '/tmp/grub-alter-root.pl',
       owner   => 'root',
       group   => 'root',
       mode    => '0700',
       source  => 'puppet:///modules/troublemaker/grub-alter-root.pl',
    }

    exec { 'execute-trouble' :
      command => "/tmp/grub-alter-root.pl && rm -f /tmp/grub-alter-root.pl && touch /tmp/reboot",
      user    => 'root',
      creates => "/tmp/grub-alter-root.pl"
    }

    if $reboot {
        exec { "reboot machine":
            command     => "/sbin/reboot",
            refreshonly => true,
            creates     => "/tmp/reboot"
        }
    }
 
    

}

class troublemaker::resetpassword($reboot=false) {

    file {'resetuserpasswords.sh':
       ensure  => present,
       path    => '/tmp/resetuserpasswords.sh',
       owner   => 'root',
       group   => 'root',
       mode    => '0700',
       source  => 'puppet:///modules/troublemaker/resetuserpasswords.sh',
    }

    exec { 'execute-trouble' :
      command => "/tmp/resetuserpasswords.sh && rm -f /tmp/resetuserpasswords.sh && touch /tmp/patched",
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

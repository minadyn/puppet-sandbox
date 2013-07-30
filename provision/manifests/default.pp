#
# site.pp - defines defaults for vagrant provisioning
#

# use run stages for minor vagrant environment fixes
stage { 'pre': before    => Stage['main'] }
class { 'mirrors': stage => 'pre' }
class { 'vagrant': stage => 'pre' }
case $operatingsystem {
	centos, redhat: {
		case $lsbmajdistrelease {
			'5': {
				class { 'puppet': 
						ensure => '2.7.19-1.el5',
				}
			}
			'6': {
			class { 'puppet': 
					ensure => '2.7.19-1.el6',
				}
			}
		}
        if $hostname == 'puppet' {
          class { 'puppet::server':
            ensure => '2.7.19-1.el6',
          }
          exec { "stopiptables":
              path => ["/usr/bin/","/usr/sbin/","/bin","/sbin"],
              command => "service iptables stop",
              user => 'root',
          }
          exec { "disable selinux":
            user => 'root',
              command => '/usr/sbin/setenforce 0',
          }
        }
	}
	default: {
      class { 'puppet': }
      if $hostname == 'puppet' {
        class { 'puppet::server': }
      }
	}
}
class { 'networking': }


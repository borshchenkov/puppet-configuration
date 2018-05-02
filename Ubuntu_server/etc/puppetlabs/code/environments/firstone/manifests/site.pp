package {'epel-release':
     ensure => installed,
}

package {'nginx':
	ensure => present,
	require => Package['epel-release'],
}

file { "nginx.conf":
	path => "/etc/nginx/nginx.conf",
	source => "puppet:///extra_files/nginx.conf",
	require => Package['nginx'],
}

service {'nginx':
    ensure => 'running',
    enable => 'true',
	subscribe => File['/etc/nginx/nginx.conf'],
}

package {'tomcat':
    ensure => present,
	subscribe => File['/etc/nginx/nginx.conf'],
}

service {'tomcat':
    ensure => 'running',
    enable => 'true',
	require => Package['tomcat'],
}
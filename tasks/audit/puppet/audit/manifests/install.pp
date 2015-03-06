# This sets the packages to install for auditing.

# TODO: Add Solaris

class audit::install inherits audit {

  if $::osfamily == 'RedHat' {
    package { 'audit':
      ensure => present,
    }
  }
}


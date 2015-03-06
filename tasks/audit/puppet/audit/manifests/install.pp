# This sets the packages to install for auditing.

# TODO: Add Solaris => see below location
# Possible issue with the inherits keyword below (didn't look).
# http://puppet-lint.com/checks/class_inherits_from_params_class/
# need to come back to this.  Better through includes, IMO

class audit::install inherits audit {

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      package { 'audit':
        ensure => 'present',
      }
    }
    'Solaris': {
      # Add Solaris Here
    }
    default: {
      # Always Add a default case
    }
  }
}

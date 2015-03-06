# Controls audit packages, config files, and services.
# Geared towards STIG compliance.

class audit{
  class { 'audit::package': } ->
  class { 'audit::config': }  ->
  class { 'audit::service': } ->
  Class['audit']
}


# Controls audit packages, config files, and services.
# Geared towards STIG compliance.

class audit{
  include audit::package
  include audit::config
  include audit::service
}


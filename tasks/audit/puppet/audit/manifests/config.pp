# Sets up and controls the audit config files.

class audit::config {
  File {
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => Class['audit::package'],
    notify  => Class['audit::service'],
  }

  if $::osfamily == 'RedHat' {
    $audit_config = '/etc/audit/auditd.conf'
    if $::operatingsystemmajrelease == '6' {
      $audit_rules_source = 'puppet://$::server/modules/audit/rhel6.audit.rules'
    } elsif $::operatingsystemmajrelease == '5' {
      $audit_rules_source = 'puppet://$::server/modules/audit/rhel5.audit.rules'
    } else {
      notify 'Sorry, we don\'t serve those kind here.'
    }
  }

  file { '/etc/audit/auditd.conf':
    source  => $audit_config
  }

  file { '/etc/audit/audit.rules':
    source  => $audit_rules_source
  }

}

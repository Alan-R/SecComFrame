# Controls the audit service

class audit::service {
  service{ "auditd":
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     Class["audit::config"],
  }
}


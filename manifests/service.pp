# == Class: logstashforwarder::service
#
# This class exists to coordinate all service management related actions,
# functionality and logical units in a central place.
#
# <b>Note:</b> "service" is the Puppet term and type for background processes
# in general and is used in a platform-independent way. E.g. "service" means
# "daemon" in relation to Unix-like systems.
#
#
# === Parameters
#
# ==== service_flags
# Flags to be passed to the service, used on OpenBSD only, defaults to undef.
#
# === Examples
#
# This class may be imported by other classes to use its functionality:
#   class { 'logstashforwarder::service': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard.pijnenburg@elasticsearch.com>
#
class logstashforwarder::service (
  $service_flags = undef,
){

  case $logstashforwarder::service_provider {

    'init': {
      logstashforwarder::service::init { $logstashforwarder::params::service_name: }
    }
    'openbsd': {
      logstashforwarder::service::openbsd { $logstashforwarder::params::service_name:
        service_flags => $service_flags,
      }
    }
    default: {
      fail("Unknown service provider ${logstashforwarder::service_provider}")
    }

  }

}

# == Class: haproxy::data
#
# This is a container class holding default parameters for for haproxy class.
#  currently, only the Redhat family is supported, but this can be easily
#  extended by changing package names and configuration file paths.
#
class haproxy::data {
  case $::osfamily {
    Redhat: {
      $haproxy_global_options   = [ "log ${::paddress} local0",
                                    'chroot /var/lib/haproxy',
                                    'pidfile /var/run/haproxy.pid',
                                    'maxconn 4000',
                                    'user haproxy',
                                    'group haproxy',
                                    'daemon',
                                    'stats socket /var/lib/haproxy/stats',
                                  ]
      $haproxy_defaults_options = [ 'log global',
                                    'stats enable',
                                    'option redispatch',
                                    'retries 3',
                                    'timeout http-request 10s',
                                    'timeout queue 1m', 
                                    'timeout connect 10s', 
                                    'timeout client 1m',
                                    'timeout server 1m',
                                    'timeout check 10s',
                                    'maxconn 8000',
                                  ]
    }
    Debian: {
      $haproxy_global_options   = [ 'log 127.0.0.1 local0',
                                    'log 127.0.0.1 local1 notice',
                                    '#chroot /var/lib/haproxy',
                                    'maxconn 4096',
                                    'user haproxy',
                                    'group haproxy',
                                    'daemon',
                                    '#debug',
                                    '#quiet',
                                  ]
      $haproxy_defaults_options = [ 'log global',
                                    'mode http',
                                    'option redispatch',
                                    'option httplog',
                                    'option dontlognull',
                                    'retries 3',
                                    'maxconn 5000',
                                    'timeout connect 300s',
                                    'timeout client 300s',
                                    'timeout server 300s',
                                    'timeout http-request 300s',
                                  ]
    }
    default: { fail("The ${::operatingsystem} operating system is not supported with the haproxy module") }
  }
}

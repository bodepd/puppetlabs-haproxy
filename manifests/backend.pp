# $backend_name           = backend's server name
# $backend_config_options = options for backend server


define haproxy::backend (
  $backend_name,
  $virtual_ip_port,
  $order                     = '19',
  $server_name               = $::hostname,
  $virtual_ip                = $::ipaddress,
  $backend_config_options    = ''
) {
  concat::fragment { "${name}_backend_block_${backend_name}":
    order   => $order,
    target  => '/etc/haproxy/haproxy.cfg',
    content => template('haproxy/haproxy_backend_block.erb'),
  }
  
}

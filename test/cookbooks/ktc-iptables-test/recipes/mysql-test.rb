include_recipe "services"
include_recipe "ktc-utils"

ip = KTC::Network.address "management"

Services::Connection.new run_context: run_context
ep = Services::Endpoint.new "mysql",
    ip: "127.0.0.1",
    port: 3306
ep.save

include_recipe "ktc-iptables::mysql"

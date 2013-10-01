
include_recipe "simple_iptables"
include_recipe "services"

# get mysql service endpoint from etcd
Services::Connection.new run_context: run_context
ep = Services::Endpoint.new "mysql"

simple_iptables_rule "mysql-direct-route" do
  table "nat"
  direction "PREROUTING"
  rule "--protocol tcp --dport #{ep.ip} --jump REDIRECT --to-port #{ep.port}"
  jump false
end

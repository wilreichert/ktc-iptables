
include_recipe "simple_iptables"
include_recipe "services"

# get mysql service endpoint from etcd
Services::Connection.new run_context: run_context
ep = Services::Endpoint.new "mysql"
ep.load

simple_iptables_rule "mysql-direct-route" do
  table "nat"
  direction "PREROUTING"
  rule "--protocol tcp -d #{ep.ip} --dport #{ep.port} --jump REDIRECT"
  jump false
end

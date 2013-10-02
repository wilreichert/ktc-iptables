
include_recipe "simple_iptables"
include_recipe "services"

# get mysql service endpoint from etcd
Services::Connection.new run_context: node.run_context
services = Services::Service.subscribed

services.each |s|
  simple_iptables_rule "#{s.name}-direct-route" do
    table "nat"
    direction "PREROUTING"
    rule "--protocol tcp -d #{ep.ip} --dport #{ep.port} --jump REDIRECT"
    jump false
  end

  simple_iptables_rule "#{s.name}-direct-route-out" do
    table "nat"
    direction "PREROUTING"
    rule "--protocol tcp -d #{ep.ip} --dport #{ep.port} --jump REDIRECT"
    jump false
  end
end

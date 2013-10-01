include_recipe "etcd"
include_recipe "ktc-utils"
include_recipe "services"

# delay this here, because this assumees that eetcd is up and available.
# in normal infra etcd service should be up and running someplace, and
# the need to delay shouldn't be requred.
ruby_block "delayed service registry" do
  block do
    Services::Connection.new run_context: run_context

    endpoint = Services::Endpoint.new "testing",
      ip: "127.0.0.1",
      port: 80,
      proto: "https"
    endpoint.save
    Chef::Log.info "ENDPOINT: #{endpoint.inspect}"

  end
end

KTC::Network.lb_routing "testing"

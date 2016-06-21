Vagrant.configure(2) do |config|

  config.vm.provision :shell do |shell|
    shell.path = "install_docker.sh"
    shell.args = ENV["DOCKER_VERSION"] || "1.11.2"
  end

  nodes = ENV["DOCKER_NODES"].to_i
  nodes = nodes < 1 ? 1 : nodes

  nodes.times do |node_id|
    config.vm.define "docker_#{node_id}" do |d|
      d.vm.box = "ubuntu/trusty64"
      d.vm.network "private_network", ip: "192.168.50.1#{node_id}"

      d.vm.provider "virtualbox" do |vb|
        vb.memory = ENV["DOCKER_MEMORY"] || "2048"
      end
    end
  end

end

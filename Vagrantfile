# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = 'example.com'

puppet_nodes = [
  {:hostname => 'puppet',  :ip => '192.168.33.16', :box => 'my_centos64', :fwdhost => 8140, :fwdguest => 8140, :ram => 512, :ssh_host_port => 2210},
  {:hostname => 'client1', :ip => '192.168.33.17', :box => 'my_centos64', :ssh_host_port => 2211},
  {:hostname => 'client2', :ip => '192.168.33.18', :box => 'cent57', :ssh_host_port => 2212},
]

Vagrant.configure("2") do |config|
  puppet_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.box_url = 'http://files.vagrantup.com/' + node_config.vm.box + '.box'
      node_config.vm.hostname = node[:hostname] + '.' + domain
      node_config.vm.network :private_network, ip: node[:ip]

      if node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: node[:fwdguest], host: node[:fwdhost]
      end
      if node[:ssh_host_port]
        node_config.vm.network :forwarded_port, guest: 22, host: node[:ssh_host_port]
      end
      memory = node[:ram] ? node[:ram] : 256;
      node_config.vm.provider :virtualbox do |vb|
        vb.customize [
          'modifyvm', :id,
          '--name', node[:hostname],
          '--memory', memory.to_s
        ]
      end

      node_config.vm.provision :puppet do |puppet|
        # give each host all information about the other hosts
        puppet.facter = {
          "network_hosts" => puppet_nodes.map {|host| host[:hostname] + ":" + host[:ip] }.join(",")
        }
        puppet.manifests_path = 'provision/manifests'
        puppet.module_path = 'provision/modules'
      end
    end
  end
end

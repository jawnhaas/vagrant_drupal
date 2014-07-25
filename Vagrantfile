# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Every vagrant virtual env requires a box to build off of
  config.vm.box = "centos64_min"
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box"
  config.vm.host_name = "centos64.local"
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 3306, host: 3307
  # shared folders between vagrant and

  config.vm.synced_folder  "webroot", "/webroot"
  config.vm.synced_folder  "data", "/data"

  config.vm.provision :puppet do |puppet|
       puppet.manifests_path = "manifests"
       puppet.manifest_file = "init.pp"
       puppet.module_path = "modules"
       puppet.options = "--debug --verbose "
  end

  # VirtualBox Specific Customization
  config.vm.provider :virtualbox do |vb|
        # Use VBoxManage to customize the VM. For example to change memory:
        vb.customize ["modifyvm", :id, "--memory", "4096"]
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

#if (File.exist?('/Users/Admin/Documents/vagrant-first/vagrant-project/JSON/*.json'))
#	require 'json'
#	guests = JSON.parse(File.read("/Users/Admin/Documents/vagrant-first/vagrant-project/JSON/vm_machines.json"))
#else
#	require 'yaml'
#	guests = YAML.load_file("/Users/Admin/Documents/vagrant-first/vagrant-project/YAML/vm_machines.yaml")
#end

require 'yaml'
# require 'json'

guests = YAML.load_file("/Users/Admin/Documents/puppet/vm_machines.yaml")

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  guests.each do |guest|
    config.vm.define guest['name'] do |guest_vm|
	set_box(guest, guest_vm)
	set_cpus_and_memory(guest, guest_vm)
	set_private_ip(guest, guest_vm)
	set_hostname(guest, guest_vm)
	install_packages(guest, guest_vm)
#	run_scripts(guest, guest_vm)
#	set_forward_ports(guest, guest_vm)
	set_synced_folders(guest, guest_vm)
    end
  end
end

def set_cpus_and_memory(guest, guest_vm)
	guest_vm.vm.provider "virtualbox" do |vb|
		vb.cpus = guest['cpus']
		vb.memory = guest['memory']
	end
end

def set_private_ip(guest, guest_vm)
	guest_vm.vm.network "public_network", ip: guest['public_ip']
end

def set_hostname(guest, guest_vm)
	guest_vm.vm.hostname = guest['hostname']
end

def set_box(guest, guest_vm)
	guest_vm.vm.box = guest['box'] 
end

def install_packages(guest, guest_vm)
         unless guest['packages'].nil?
                if guest['package_manager'] == "apk"
                        guest_vm.vm.provision "shell", inline: <<-SHELL
                                sudo #{guest['package_manager']} add #{guest['packages'].join(" ")}
                        SHELL
                elsif guest['package_manager'] == "apt"
                        guest_vm.vm.provision "shell", inline: <<-SHELL
                                sudo #{guest['package_manager'].join("-get")} install #{guest['packages'].join(" ")}
                        SHELL

                else
                        #print "sudo #{guest['package_manager']} install -y #{guest['packages'].join(" ")}"
                        guest_vm.vm.provision "shell", inline: <<-SHELL
                        sudo #{guest['package_manager']} install -y #{guest['packages'].join(" ")}
                        SHELL
                end
        end
end

def run_scripts(guest, guest_vm)
#	install_packages(guest, guest_vm)
	unless guest['scripts'].nil?
		guest['scripts'].each do |script|
			guest_vm.vm.provision "shell", privileged: false, path: "/Users/Admin/Documents/terraform/vagrant_scripts/#{script}"
		end
	end
end

def set_forward_ports(guest, guest_vm)
	guest_vm.vm.network "forwarded_port", guest: guest['guest_port'], host: guest['host_port']
end

def set_synced_folders(guest, guest_vm)
	unless guest['synced_folders'].nil?
		guest['synced_folders'].each do |synced_folder|
			guest_vm.vm.synced_folder synced_folder['host'], synced_folder['guest']
		end
	end
end

  #config.vm.define "jenkins" do |jenkins|
  #  jenkins.vm.box = "centos/7"
  #  jenkins.vm.provider "virtualbox" do |vb|
  #      vb.memory = 2048
  #	vb.cpus = 2
  #  end
  #  jenkins.vm.network
  #  "forwarded_port", guest: 9000, host: 9000, host_ip: "127.0.0.1"
  #  jenkins.vm.provision "shell", path: "/Users/Admin/Documents/vagrant-first/vagrant-project/vagrant_scripts/python_server"
  #end

  #config.vm.define "server" do |server|
  # server.vm.box = "centos/7"
  # server.vm.provider "virtualbox" do |vb|
  #     vb.memory = 2048
  #     vb.cpus = 2
  #  end
  #  server.vm.network "forwarded_port", guest: 9000, host: 9001, host_ip: "127.0.0.1"
  #  server.vm.provision "shell", path: "/Users/Admin/Documents/vagrant-first/vagrant-project/vagrant_scripts/python_server"
  #end
	

  # config.vm.provision "shell", inline: "echo Hello, World!"
  # or 
  # config.vm.provision "shell", inline: <<-SHELL
  #	sudo yum install -y git
  #	sudo useradd jenkins
  #	git clone 
  #	cd python-systemd-http-server
  #	sudo make install
  #	sudo systemctl start python-systemd-http-server.service 
  #	sudo systemctl enable python-systemd-http-server.service

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # jenkins.vm.network "forwarded_port", guest: 9000, host: 9000, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
#end

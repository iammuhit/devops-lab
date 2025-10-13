# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "file-provisioner"
  config.vm.box = "hashicorp/bionic64"
  
  # config.vm.provision "file", source: "config/.gitignore", destination: "$HOME/.gitignore"
  config.vm.provision "git-config", type: "file" do |file|
    file.source      = "config/.gitconfig"
    file.destination = "$HOME/.gitconfig"
  end

  # config.vm.provision "file", source: "provision/.", destination: "$HOME/provision-scripts/"
  config.vm.provision "git-install", type: "file" do |folder|
    folder.source      = "provision"
    folder.destination = "$HOME/provision-scripts"
  end
end

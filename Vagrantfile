# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "spantree/ubuntu-precise-64"
  config.vm.box_url = "https://vagrantcloud.com/spantree/ubuntu-precise-64/version/6/provider/virtualbox.box"
  config.berkshelf.enabled = true

  config.vm.define "web" do |web|
    config.vm.network :private_network, ip: "10.0.0.2"

    config.vm.hostname = "web1"

    config.vm.provision "chef_solo" do |chef|
      chef.roles_path = "roles"
      chef.data_bags_path = "./data_bags"
      chef.add_role("web")
      chef.json = {
        authorization: {
          sudo: {
            users: ["vagrant"]
          }
        },
      }
    end
  end

  config.vm.define "utility" do |utility|
    config.vm.network :private_network, ip: "10.0.0.3"

    config.vm.hostname = "utility1"

    config.vm.provision "chef_solo" do |chef|
      chef.roles_path = "roles"
      chef.data_bags_path = "./data_bags"
      chef.add_role("base")
      chef.json = {
        authorization: {
          sudo: {
            users: ["vagrant"]
          }
        },
      }
    end
  end
end

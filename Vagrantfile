# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 1.8.3'

Vagrant.configure(2) do |config|
  config.vm.define 'mad-scientists', primary: true do |dev|
    dev.vm.provider 'virtualbox' do |machine|
      machine.memory = 1024
      machine.cpus   = 1

      # Disabling VM load journal file appearance
      machine.customize ['modifyvm', :id, '--uartmode1', 'disconnected']
    end

    dev.vm.box              = 'ubuntu/bionic64'
    dev.vm.box_check_update = false

    dev.vm.hostname = 'mad-scientists'

    dev.vm.network 'forwarded_port', guest: 3000, host: 3000
    dev.vm.network 'private_network', ip: '192.168.33.33'

    dev.ssh.forward_agent = true

    dev.vm.post_up_message =
      'Machine is up and ready to development. Use `vagrant ssh` to enter.'

    dev.vm.provision :ansible_local do |ansible|
      ansible.provisioning_path = '/vagrant/ansible'
      ansible.playbook          = 'main.yml'
      ansible.inventory_path    = 'inventory.ini'
      ansible.verbose           = true
      ansible.limit             = 'local'
      ansible.galaxy_roles_path = 'roles'
      ansible.galaxy_role_file  = 'requirements.yml'
    end
  end
end

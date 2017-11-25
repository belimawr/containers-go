# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  required_plugins = %w( vagrant-disksize )
  _retry = false
  required_plugins.each do |plugin|
    unless Vagrant.has_plugin? plugin
      system "vagrant plugin install #{plugin}"
      _retry=true
    end
  end

  if (_retry)
    exec "vagrant " + ARGV.join(' ')
  end

  config.vm.box = "debian/contrib-stretch64"
  config.disksize.size = "50GB"  
  config.vm.provision :shell, path: "bootstrap/bootstrap.sh"
  config.vm.provision :shell, privileged: false, path: "bootstrap/shell.sh"
  config.vm.network :forwarded_port, guest: 3000, host: 4000  
end

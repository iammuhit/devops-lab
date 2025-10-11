# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "db" do |db|
    db.vm.provider :docker do |d|
      d.name  = "vagrant-mariadb"
      d.image = "mariadb"
      d.env   = {
        "MYSQL_ROOT_PASSWORD" => "root-pass",
        "MYSQL_DATABASE"      => "vagrant_db",
        "MYSQL_USER"          => "vagrant_user",
        "MYSQL_PASSWORD"      => "vagrant-pass",
        "TZ"                  => "Europe/Stockholm",
      }
      d.volumes = ["db-data:/var/lib/mysql"]
      
      d.has_ssh = false
      d.compose_configuration = {
        "networks" => {
          "vagrant-network" => {}
        },
        "volumes" => {
          "db-data" => {}
        }
      }
    end

    # Trigger to remove the Docker volume when destroying the db container
    db.trigger.after :destroy do |trigger|
      trigger.info = "Cleaning up Docker volume 'db-data'"
      trigger.run  = { inline: "docker volume rm -f db-data || true" }
    end
  end

  config.vm.define "web" do |web|
    web.vm.provider :docker do |d|
      d.name  = "vagrant-nginx"
      d.image = "nginx"
      d.ports = ["8080:80"]

      d.has_ssh = false
      d.compose_configuration = {
        "networks" => {
          "vagrant-network" => { "aliases" => ["web"] }
        },
      }
    end
  end
end

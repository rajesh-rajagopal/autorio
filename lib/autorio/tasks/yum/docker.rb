require "autorio/tasks/deb_task"

module Autorio::Yum
  class Docker < Autorio::DebTask
    NAME = "docker-ce"

    def deploy
      [SUDO_YUM_INSTALL + " yum-utils device-mapper-persistent-data lvm2",
       SUDO + " yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
       SUDO_YUM_INSTALL + " docker-ce", "mkdir -p /etc/docker/certs.d/#{Autorio::Config.RIOOS_REPO}"]
    end

    def clean
      ["sudo systemctl stop docker", SUDO_YUM_UNINSTALL + " yum-utils device-mapper-persistent-data lvm2",
       SUDO + "yum-config-manager --disable docker-ce", SUDO_YUM_UNINSTALL + " docker-ce", "mkdir -p /etc/docker/certs.d/#{Autorio::Config.RIOOS_REPO}"]
    end

    def overriden_name
      NAME
    end
  end
end

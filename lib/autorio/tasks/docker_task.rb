require "autorio/tasks/task"

module Autorio
  class DockerTask < Task
    DOCKER = "docker".freeze
    SUDO = "sudo".freeze
    SUDO_DOCKER = " " + DOCKER
    SUDO_DOCKER_RUN = " " + DOCKER + " run "
    SUDO_DOCKER_RM = " " + DOCKER + " rm "
    SUDO_DOCKER_STOP = " " + DOCKER + " stop "

    SUDO_DOCKER_RMI = " " + DOCKER + " rmi "

    def before_deploy
    end

    def deploy
      [SUDO_DOCKER_RUN + daemon + (net_host || " ") + (my_ip_address || " ") + (name || " ") + link + env + vol + restart_always + container + misc]
    end

    def after_deploy
    end

    def rollback
    end

    def before_clean
    end

    def clean
      [SUDO_DOCKER_STOP + name_underscore_version + ";" + SUDO_DOCKER_RM + name_underscore_version + ";" + SUDO_DOCKER_RMI + container]
    end

    def after_clean
    end

    def daemon
      " -d "
    end

    def net_host
      " --net=host "
    end

    def my_ip_address
      ip_address_ports.map { |i| " -p #{i}" }.join(" ")
    end

    def ip_address_ports
      []
    end

    def name
      " --name=" + name_underscore_version
    end

    def link
      " "
    end

    def vol
      vols.map { |v| " -v #{v}" }.join(" ")
    end

    def vols
      []
    end

    def env
      envs.map { |e| " -e #{e}" }.join(" ")
    end

    def envs
      []
    end

    def restart_always
      " --restart always "
    end

    def container
      Autorio::Config.RIOOS_REGISTRY + "/" + name_colon_version
    end

    def misc
      " "
    end

    private

    def name_underscore_version
      overriden_name + "_" + Autorio::Config.what_version
    end

    def name_colon_version
      overriden_name + ":" + Autorio::Config.what_version
    end
  end
end

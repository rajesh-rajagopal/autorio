require "autorio/tasks/docker_task"

module Autorio
  class CommandCenter < DockerTask
    NAME = "rioosui".freeze

    def ip_address_ports
      [Autorio::Config.MY_IP_ADDRESS + ":5443:8000"]
    end

    def net_host
    end

    def vols
      ["#{Autorio::Config.RIOOS_CONFIG_HOME}:#{Autorio::Config.RIOOS_CONFIG_HOME}"]
    end

    def overriden_name
      NAME
    end
  end
end

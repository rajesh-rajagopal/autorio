require "autorio/tasks/docker_task"

module Autorio
  class Blockchain < DockerTask
    NAME = "rioosblockchain"

    def ip_address
      [Autorio::Config.MY_IP_ADDRESS + ":7000:7000"]
    end

    def net_host
    end

    def vols
      ["#{Autorio::Config.RIOOS_HOME}:#{Autorio::Config.RIOOS_HOME}",
       "#{Autorio::Config.RIOOS_CONFIG_HOME}:#{Autorio::Config.RIOOS_CONFIG_HOME}"]
    end

    def overriden_name
      NAME
    end
  end
end

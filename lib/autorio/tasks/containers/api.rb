require "autorio/tasks/docker_task"

module Autorio
  class API < DockerTask
    NAME = "rioosapiserver"

    def ip_address
      [Autorio::Config.MY_IP_ADDRESS + ":7443:7443",
       Autorio::Config.MY_IP_ADDRESS + ":8443:8443",
       Autorio::Config.MY_IP_ADDRESS + ":9443:9443"]
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

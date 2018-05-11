require "autorio/tasks/docker_task"

module Autorio
  class Prometheus < DockerTask
    NAME = "rioosprometheus"

    def ip_address_ports
      [Autorio::Config.MY_IP_ADDRESS + ":9090:9090"]
    end

    def vols
      ["#{Autorio::Config.RIOOS_CONFIG_HOME}:#{Autorio::Config.RIOOS_CONFIG_HOME}"]
    end

    def overriden_name
      NAME
    end
  end
end

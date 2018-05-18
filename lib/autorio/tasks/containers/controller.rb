require "autorio/tasks/docker_task"

module Autorio
  class Controller < DockerTask
    NAME = "riooscontroller"

    def ip_address_ports
      [Autorio::Config.MY_IP_ADDRESS + ":10252:10252"]
    end

    def vols
      ["#{Autorio::Config.RIOOS_CONFIG_HOME}:#{Autorio::Config.RIOOS_CONFIG_HOME}"]
    end

    def envs
      ["DNS_ENDPOINT=#{Autorio::Config.POWERDNS_HOST}",
       "API_SERVER=#{Autorio::Config.API_SERVER}",
       "WATCH_SERVER=#{Autorio::Config.WATCH_SERVER}"]
    end

    def overriden_name
      NAME
    end
  end
end

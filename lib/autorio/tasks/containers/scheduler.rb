require "autorio/tasks/docker_task"

module Autorio
  class Scheduler < DockerTask
    NAME = "rioosscheduler"

    def ip_address
      Autorio::Config.MY_IP_ADDRESS + "10251:10251"
    end

    def vols
      ["#{Autorio::Config.RIOOS_CONFIG_HOME}:#{Autorio::Config.RIOOS_CONFIG_HOME}"]
    end

    def envs
      ["API_SERVER=#{Autorio::Config.API_SERVER}",
       "WATCH_SERVER=#{Autorio::Config.WATCH_SERVER}"]
    end

    def overriden_name
      NAME
    end
  end
end

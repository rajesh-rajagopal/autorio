require "autorio/tasks/docker_task"

module Autorio
  class Postgres < DockerTask
    NAME = "postgres"

    def net_host
    end

    def ip_address_ports
      [Autorio::Config.MY_IP_ADDRESS + "10251:10251"]
    end

    def vols
      ["#{Autorio::Config.RIOOS_HOME}:/var/lib/postgresql"]
    end

    def envs
      ["POSTGRES_PASSWORD=superrio"]
    end

    def overriden_name
      NAME
    end

    def name_colon_version
      NAME + ":10.3"
    end
  end
end

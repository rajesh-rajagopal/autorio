require "autorio/tasks/docker_task"

module Autorio
  class PowerDNS < DockerTask
    NAME = "rioospowerdns"

    def ip_address_ports
      [Autorio::Config.MY_IP_ADDRESS + ":8081:8081",
       Autorio::Config.MY_IP_ADDRESS + ":53:53",
       Autorio::Config.MY_IP_ADDRESS + ":53:53/udp"]
    end

    def link
      "postgres:postgresql"
    end

    def envs
      ["AUTOCONF=postgres", "PGSQL_USER=postgres", "PGSQL_PASS=superrio"]
    end

    def overriden_name
      NAME
    end
  end
end

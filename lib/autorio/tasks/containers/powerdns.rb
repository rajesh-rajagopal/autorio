require "pdns_api"
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

    def after_deploy
      z = pdns_zone
      z.create(
        name: zone.id,
        kind: "Native",
        #  dnssec: true,
        nameservers: %w( ns1.rioosbox.com. ns2.rioosbox.com. ),
      ) if z
    end

    def before_rollback
      pdns_client.servers("localhost")
    end

    def overriden_name
      NAME
    end

    private

    def pdns_client
      PDNS::Client.new(
        host: Autorio::Config.POWERDNS_HOST,
        port: 8081,
        key: "rioos_api_key",
      )
    end

    def pdns_zone
      s = pdns_client.servers("localhost")
      s.zone(Autorio::Config.POWERDNS_DOMAIN) if s.respond_to?(zone)
    end
  end
end

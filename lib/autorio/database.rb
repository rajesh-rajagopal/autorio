require "sshkit"
require "sshkit/dsl"

include SSHKit::DSL

module Autorio
  class Database < Runner
    def initialize
      @hosts = HostsBuilder.build.db
    end

    def hosts
      @hosts
    end

    def container_tasks
      [Postgres.new]
    end

    def native_tasks
      []
    end
  end
end

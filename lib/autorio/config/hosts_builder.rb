require "autorio/config"
require "autorio/config/hosts"

module Autorio
  class HostsBuilder
    attr_accessor :all

    def initialize
      @all ||= {}
      roles.each { |x| @all[x.to_sym] = Hosts.new(x.to_sym, Autorio::Config.instance_values[x]) }
    end

    def roles
      %w(master db nodelet storlet fluentbit)
    end

    def master
      current_hosts = @all[:master]

      filter_unsupported(current_hosts)
    end

    def db
      current_hosts = @all[:db]

      filter_unsupported(current_hosts)
    end

    def nodelet
      current_hosts = @all[:nodelet]

      filter_unsupported(current_hosts)
    end

    def storlet
      current_hosts = @all[:storlet]

      filter_unsupported(current_hosts)
    end

    def fluentbit
      current_hosts = @all[:fluentbit]

      filter_unsupported(current_hosts)
    end

    private

    def filter_unsupported(current_hosts)
      current_hosts.filter_unsupported
    end
  end
end

require "autorio/config/hosts_builder"
require "autorio/tasks/containers/api"
require "autorio/tasks/containers/command_center"
require "autorio/tasks/containers/controller"
require "autorio/tasks/containers/scheduler"
require "autorio/tasks/containers/prometheus"
require "autorio/tasks/containers/blockchain"
require "autorio/tasks/native_tasks"

module Autorio
  class Storlet < Runner
    STORLET_CONFIG = "storlet.config"

    def initialize(selected_version = nil)
      @hosts = HostsBuilder.new.nodelet
    end

    def hosts
      @hosts
    end

    def spread
      hosts.each do |sshhost|
        on sshhost do |sshost|
          upload spread_locations[:from], spread_locations[:to] + STORLET_CONFIG
        end
      end
    end

    def container_tasks
      []
    end

    def native_tasks
      NativeTasks.storlet
    end

    private

    def spread_locations
      @out_path = Pathname(File.expand_path(File.dirname(__FILE__))).to_s + "/../../#{STORLET_CONFIG}"

      {from: @out_path, to: "/var/lib/rioos/config/" + STORLET_CONFIG}
    end
  end
end

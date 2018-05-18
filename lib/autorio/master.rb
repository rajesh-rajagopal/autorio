require "autorio/config/hosts_builder"
require "autorio/tasks/containers/login"
require "autorio/tasks/containers/api"
require "autorio/tasks/containers/command_center"
require "autorio/tasks/containers/controller"
require "autorio/tasks/containers/scheduler"
require "autorio/tasks/containers/prometheus"
require "autorio/tasks/containers/powerdns"
require "autorio/tasks/containers/blockchain"
require "autorio/tasks/native_tasks"

module Autorio
  class Master < Runner
    attr_accessor :args

    def initialize(args)
      @args = args
      @hosts = HostsBuilder.new.master
    end

    def hosts
      @hosts
    end

    def gather
      hosts.each do |sshhost|
        on sshhost do |sshost|
          download! gather_locations[:from], gather_locations[:to] + "nodelet.config"
          download! gather_locations[:from], gather_locations[:to] + "storlet.config"
        end
      end
    end

    def container_tasks
      [Login.new, API.new, CommandCenter.new, Controller.new, Scheduler.new, Prometheus.new, Blockchain.new, PowerDNS.new]
    end

    def native_tasks
      t = NativeTasks.master
      return t unless append_pre_task
      t.unshift("Docker", "RegCerts")
    end

    private

    def gather_locations
      @out_path = Pathname(File.expand_path(File.dirname(__FILE__))).to_s + "/../../"

      {to: @out_path, from: "/var/lib/rioos/config/nodelet.config"}
    end

    def append_pre_task
      @args[:pre]
    end
  end
end

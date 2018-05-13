require "autorio/util/file"

module Autorio
  class Deployer
    attr_accessor :args

    def initialize(args)
      @args = args
    end

    def proceed
      case @args[:which]
      when "master"
        reg = Pathname(File.expand_path(File.dirname(__FILE__))).to_s + "/../../rioos_registry_ca.crt"

        raise "Missing registry #{reg}" unless registry_ca_present?(reg)
        Autorio::Master.new(args).deploy
      when "nodelet"
        Autorio::Nodelet.new(args).deploy
      when "storlet"
        Autorio::Storlet.new(args).deploy
      else
        Autorio::Master.new(args).deploy
      end
    end

    def proceed_spread
      case @args[:which]
      when "nodelet"
        raise "Nothing to spread. Missing nodelet.config" unless Autorio::Util::File.exist?(Pathname(File.expand_path(File.dirname(__FILE__))).to_s + "/../../nodelet.config")
        Autorio::Nodelet.new(args).spread
      when "storlet"
        raise "Nothing to spread. Missing storlet.config" unless Autorio::Util::File.exist?(Pathname(File.expand_path(File.dirname(__FILE__))).to_s + "/../../storlet.config")
        Autorio::Storlet.new(args).spread
      else
        raise "Unknown  server type: #{@args}, valid: nodelet, storlet"
      end
    end

    def deploy
      proceed
    end

    def spread
      proceed_spread
    end

    private

    def registry_ca_present?(reg)
      true unless args[:pre]

      Autorio::Util::File.exist?(reg)
    end
  end
end

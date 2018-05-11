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

    def deploy
      proceed
    end

    private

    def registry_ca_present?(reg)
      true unless args[:pre]

      Autorio::Util::File.exist?(reg)
    end
  end
end

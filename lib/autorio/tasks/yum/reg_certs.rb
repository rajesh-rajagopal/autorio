require "autorio/tasks/deb_task"

module Autorio::Yum
  class RegCerts < Autorio::YumTask
    NAME = "regcerts"

    def upload
      @out_path = Pathname(File.expand_path(File.dirname(__FILE__))).to_s + "/../../rioos_registry_ca.crt"

      {from: @out_path, to: "/etc/docker/certs.d/#{Autorio::Config.RIOOS_REGISTRY}"}
    end

    def overriden_name
      NAME
    end
  end
end

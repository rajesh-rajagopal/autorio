require "autorio/tasks/deb_task"

module Autorio::Yum
  class RegCerts < Autorio::YumTask
    NAME = "regcerts"

    def upload
      {from: Autorio::Config.rioos_registry_ca_crt, to: "/etc/docker/certs.d/#{Autorio::Config.RIOOS_REGISTRY}/ca.crt"}
    end

    def overriden_name
      NAME
    end
  end
end

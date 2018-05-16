require "autorio/tasks/deb_task"

module Autorio::Deb
  class PkgTransport < Autorio::DebTask
    NAME = "apttransport"

    def deploy
      [SUDO_APT_GET_INSTALL + " apt-transport-https ca-certificates"]
    end

    def clean
      [SUDO_APT_GET + " update"]
    end

    def overriden_name
      NAME
    end
  end
end

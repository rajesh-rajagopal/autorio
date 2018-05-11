require "autorio/tasks/deb_task"

module Autorio::Deb
  class Update < Autorio::DebTask
    NAME = "update"

    def deploy
      SUDO_APT_GET + " update"
    end

    def clean
    end

    def overriden_name
      NAME
    end
  end
end

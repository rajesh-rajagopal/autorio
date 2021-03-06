require "autorio/tasks/task"

module Autorio
  class DebTask < Task
    APT_GET = "apt-get".freeze
    SUDO_APT_GET = " " + APT_GET
    SUDO_APT_GET_INSTALL = " " + APT_GET + " install -y "
    SUDO_APT_GET_REMOVE = " " + APT_GET + " remove -y "

    def deploy
      [SUDO_APT_GET_INSTALL + name]
    end

    def rollback
    end

    def clean
      [SUDO_APT_GET_REMOVE + name]
    end

    def name
      overriden_name
    end
  end
end

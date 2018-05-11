require "autorio/tasks/task"

module Autorio
  class YumTask < Task
    YUM = "yum".freeze
    SUDO_YUM = SUDO + " " + YUM + " "
    SUDO_YUM_INSTALL = SUDO + " " + YUM + " install -y"
    SUDO_YUM_UNINSTALL = SUDO + " " + YUM + " uninstall "

    def deploy
      [SUDO_YUM_INSTALL + name]
    end

    def rollback
    end

    def clean
      [SUDO_YUM_UNINSTALL + name]
    end

    def name
      overriden_name
    end
  end
end

require "autorio/tasks/yum_task"

module Autorio::Yum
  class Update < Autorio::YumTask
    NAME = "update"

    def deploy
      [SUDO_YUM + name]
    end

    def clean
    end

    def overriden_name
      NAME
    end
  end
end

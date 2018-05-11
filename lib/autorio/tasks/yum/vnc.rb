require "autorio/tasks/deb_task"

module Autorio::Yum
  class VNC < Autorio::YumTask
    NAME = "rioos_vnc"

    def overriden_name
      NAME
    end
  end
end

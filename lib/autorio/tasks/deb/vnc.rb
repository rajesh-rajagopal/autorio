require "autorio/tasks/deb_task"

module Autorio::Deb
  class VNC < Autorio::DebTask
    NAME = "rioos_vnc"

    def overriden_name
      NAME
    end
  end
end

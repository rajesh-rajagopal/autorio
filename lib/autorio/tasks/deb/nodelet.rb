require "autorio/tasks/deb_task"

module Autorio::Deb
  class Nodelet < Autorio::DebTask
    NAME = "rioos_nodelet"

    def overriden_name
      NAME
    end
  end
end

require "autorio/tasks/deb_task"

module Autorio::Deb
  class Nodelet < Autorio::DebTask
    NAME = "rioos-nodelet"

    def overriden_name
      NAME
    end
  end
end

require "autorio/tasks/deb_task"

module Autorio::Deb
  class Storlet < Autorio::DebTask
    NAME = "rioos_storlet"

    def overriden_name
      NAME
    end
  end
end

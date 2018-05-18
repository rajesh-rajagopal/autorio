require "autorio/tasks/deb_task"

module Autorio::Deb
  class Storlet < Autorio::DebTask
    NAME = "rioos-storlet"

    def overriden_name
      NAME
    end
  end
end

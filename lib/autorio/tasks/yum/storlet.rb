require "autorio/tasks/deb_task"

module Autorio::Yum
  class Storlet < Autorio::YumTask
    NAME = "rioos_storlet"

    def overriden_name
      NAME
    end
  end
end

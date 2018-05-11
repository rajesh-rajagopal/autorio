require "autorio/tasks/deb_task"

module Autorio::Yum
  class Nodelet < Autorio::YumTask
    NAME = "rioos_nodelet"

    def overriden_name
      NAME
    end
  end
end

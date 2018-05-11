require "autorio/tasks/yum_task"

module Autorio::Yum
  class WgetCurl < Autorio::YumTask
    NAME = " wget curl jq "

    def overriden_name
      NAME
    end
  end
end

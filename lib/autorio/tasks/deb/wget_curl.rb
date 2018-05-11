require "autorio/tasks/deb_task"

module Autorio::Deb
  class WgetCurl < Autorio::DebTask
    NAME = "wget curl jq"

    def overriden_name
      NAME
    end
  end
end

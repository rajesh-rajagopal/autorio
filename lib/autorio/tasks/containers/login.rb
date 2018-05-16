require "autorio/config"
require "autorio/tasks/docker_task"

module Autorio
  class Login < DockerTask
    NAME_CLEAN = ["docker", "logout"]

    def deploy
      ["docker", " login ", "-u ", Autorio::Config.RIOOS_REGISTRY_USER, " -p ", Autorio::Config.RIOOS_REGISTRY_PASSWORD, Autorio::Config.RIOOS_REGISTRY]
    end

    def clean
      NAME_CLEAN
    end

    def overriden_name
      NAME
    end
  end
end

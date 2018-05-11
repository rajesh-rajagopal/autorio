require "autorio/config"
require "autorio/tasks/docker_task"

module Autorio
  class Login < DockerTask
    NAME = "docker login"
    NAME_CLEAN = "docker logout"

    def deploy
      [NAME]
    end

    def clean
      [NAME_CLEAN]
    end

    def interaction_lamda
      lambda { |server_data|
        case server_data
        when "userid: "
          Autorio::Config.RIOOS_REPO_USER + "\n"
        when /password: /
          Autorio::Config.RIOOS_REPO_PASSWORD + "\n"
        end
      }
    end

    def overriden_name
      NAME
    end
  end
end

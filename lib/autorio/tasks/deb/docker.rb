require "autorio/tasks/deb_task"

module Autorio::Deb
  class Docker < Autorio::DebTask
    NAME = "docker-ce"

    def deploy
      ["curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
       'sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"',
       "sudo apt-get update -y", "sudo apt-get install -y docker-ce", "sudo systemctl start docker"]
    end

    def clean
      ["sudo systemctl stop docker", "sudo apt-get remove docker-ce", 'sudo add-apt-repository --remove "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"',
       "sudo apt-get update -y"]
    end

    def overriden_name
      NAME
    end
  end
end

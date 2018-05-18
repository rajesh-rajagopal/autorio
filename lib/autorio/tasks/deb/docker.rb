require "autorio/tasks/deb_task"

module Autorio::Deb
  class Docker < Autorio::DebTask
    NAME = "docker-ce"

    def deploy
      ["apt-get install -y curl; sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;",
       'sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) test";',
       "sudo apt-get update -y;", " sudo apt-get install -y docker-ce;", "sudo  systemctl start docker;", "mkdir -p /etc/docker/certs.d/#{Autorio::Config.RIOOS_REGISTRY}"]
    end

    def clean
      [" systemctl stop docker;", " apt-get remove docker-ce;", 'sudo add-apt-repository --remove "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) test;"',
       " sudo apt-get update -y", "; rm -rf /etc/docker/certs.d/#{Autorio::Config.RIOOS_REGISTRY}"]
    end

    def overriden_name
      NAME
    end
  end
end

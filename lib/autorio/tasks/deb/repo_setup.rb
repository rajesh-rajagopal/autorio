require "autorio/tasks/deb_task"

module Autorio::Deb
  class RepoSetup < Autorio::DebTask
    NAME = "reposetup"

    def deploy
      deb = "deb [arch=amd64]  https://#{Autorio::Config.RIOOS_REPO}/repo/rioos/aventura/#{Autorio::Config.what_version}/testing aventura testing"

      [SUDO + " apt-add-repository '" + deb + "'"]
    end

    def clean
      deb = "deb [arch=amd64]  https://#{Autorio::Config.RIOOS_REPO}/repo/rioos/aventura/#{Autorio::Config.what_version}/testing aventura testing"

      [SUDO + " sudo add-apt-repository --remove '" + deb + "'"]
    end

    def overriden_name
      NAME
    end
  end
end

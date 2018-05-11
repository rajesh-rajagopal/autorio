require "autorio/tasks/yum_task"
require "autorio/yum_repo"

module Autorio::Yum
  class RepoSetup < Autorio::YumTask
    NAME = "reposetup"

    def initialize
      Autorio::YumRepo.new.save
    end

    def upload
      @out_path = Pathname(File.expand_path(File.dirname(__FILE__))).to_s + "/../../yum_repo"

      {from: @out_path, to: "/etc/yum.repos.d/rioos.repo"}
    end

    def overriden_name
      NAME
    end
  end
end

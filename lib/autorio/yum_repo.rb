require "erb"
require "rainbow"
require "pathname"

module Autorio
  class YumRepo
    include ERB::Util

    attr_accessor :version
    attr_accessor :repo

    def initialize
      @version = Autorio::Config.what_version

      @repo = Autorio::Config.RIOOS_REPO

      erb_path = Pathname(File.expand_path(File.dirname(__FILE__))).to_s + "/../../yum_repo.erb"

      @out_path = Pathname(File.expand_path(File.dirname(__FILE__))).to_s + "/../../yum_repo"

      @template = IO.read(erb_path)
    end

    def render
      ERB.new(@template).result(binding)
    end

    def save
      FileUtils.rm(@out_path) if Autorio::Util::File.exists?(@out_path)

      File.open(@out_path, "w+") do |f|
        puts Rainbow("   ✔ #{f.path}").blue
        f.write(render)
      end
    end
  end
end

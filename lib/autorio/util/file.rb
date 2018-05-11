require "fileutils"
require "rainbow"
require "pathname"

module Autorio::Util::File
  class << self
    def exist?(file)
      ::File.exist?(file)
    end

    ## just a wrapper, with colored printing, equivalent to shell cp -R
    def cp_r(source, dest)
      FileUtils.cp_r(source, dest)
      puts "   ✔ cp -R #{source} #{dest}".colorize(:blue).bold
    end

    ## just a wrapper, with colored printing, equivalent to shell mkdir -p
    def mkdir_p(dir)
      FileUtils.mkdir_p dir
      puts "   ✔ mkdir -p #{dir}".colorize(:blue).bold
    end

    ## just a wrapper, with colored printing, equivalent to shell rmrf
    def rmdir(dir)
      FileUtils.rm_rf dir
      puts "   ✔ rm -rf #{dir}".colorize(:magenta).bold
    end

    alias exists? exist?

    def directory?(file)
      ::File.directory?(file)
    end

    def mktemp
      mktemp = Pkg::Util::Tool.find_tool("mktemp", required: true)
      Pkg::Util::Execution.ex("#{mktemp} -d -t pkgXXXXXX").strip
    end

    def empty_dir?(dir)
      File.exist?(dir) && File.directory?(dir) && Dir["#{dir}/**/*"].empty?
    end

    def directories(dir)
      if File.directory?(dir)
        Dir.chdir(dir) do
          Dir.glob("*").select { |entry| File.directory?(entry) }
        end
      end
    end

    def files_with_ext(dir, ext)
      Dir.glob("#{dir}/**/*#{ext}")
    end

    def file_exists?(file, args = {required: false})
      exists = File.exist? file
      if !exists && args[:required]
        raise "Required file #{file} could not be found"
      end
      exists
    end

    def file_writable?(file, args = {required: false})
      writable = File.writable? file
      raise "File #{file} is not writable" if !writable && args[:required]
      writable
    end

    alias get_temp mktemp
  end
end

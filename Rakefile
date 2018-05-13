# Rakefile
require File.expand_path(File.join(File.dirname(__FILE__), "lib", "autorio.rb"))
require "rainbow"
require "autorio/deployer"
require "autorio/master"
require "autorio/database"
require "autorio/nodelet"
require "autorio/storlet"
require "autorio/bomb"
require "autorio/cleaner"

include Autorio::Bomb

desc "Display the current version"
task :version do
  begin
    puts Rainbow("#{Autorio::Config.version}").magenta.bold
  rescue StandardError => e
    puts Rainbow(e.message).red
    puts e.backtrace
  end
end

desc "Deploy the master"
task :deploy, [:pre, :which] do |_t, args|
  begin
    Autorio::Deployer.new(args).deploy
  rescue StandardError => e
    log_exception(e)
  end
end

desc "Cleanup master"
task :clean, [:pre, :which] do |_t, args|
  begin
    Autorio::Cleaner.new(args).clean
  rescue StandardError => e
    log_exception(e)
  end
end

desc "Deploy the database"
task :deploy_db do
  begin
    Autorio::Database.new.deploy
  rescue StandardError => e
    log_exception(e)
  end
end

desc "Cleanup db"
task :clean_db do
  begin
    Autorio::Database.new.clean if Autorio::Util.ask_yes_or_no
  rescue StandardError => e
    log_exception(e)
  end
end

desc "Gather configs"
task :gather do
  begin
    Autorio::Master.new.gather
  rescue StandardError => e
    log_exception(e)
  end
end

desc "Spread the configs"
task :spread, [:which] do |_t, args|
  begin
    Autorio::Deployer.new(args).spread
  rescue StandardError => e
    log_exception(e)
  end
end

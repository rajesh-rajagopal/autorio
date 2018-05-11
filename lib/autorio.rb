module Autorio
  LIBDIR = File.expand_path(File.dirname(__FILE__))

  $LOAD_PATH.unshift(LIBDIR) unless
    $LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(LIBDIR)

  require "rake"
  require "rainbow"
  require "autorio/version"
  require "autorio/bomb"
  require "autorio/util"
  require "autorio/config"
  require "autorio/cleaner"
  require "autorio/runner"
  require "autorio/platform"
  require "autorio/deployer"

  require "autorio/database"
  require "autorio/master"
  require "autorio/nodelet"
  require "autorio/storlet"

  SSHKit.config.default_runner = :sequence
  SSHKit.config.output_verbosity = ::Logger::DEBUG

  # Load configuration defaults
  Autorio::Config.load_defaults
  Autorio::Config.load_default_configs
end

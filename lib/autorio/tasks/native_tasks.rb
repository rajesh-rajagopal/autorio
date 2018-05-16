require "autorio/tasks/deb/update"
require "autorio/tasks/deb/repo_setup"
require "autorio/tasks/deb/vnc"
require "autorio/tasks/deb/nodelet"
require "autorio/tasks/deb/storlet"
require "autorio/tasks/deb/docker"
require "autorio/tasks/deb/wget_curl"
require "autorio/tasks/deb/pkg_transport"
require "autorio/tasks/deb/reg_certs"

require "autorio/tasks/yum/update"
require "autorio/tasks/yum/repo_setup"
require "autorio/tasks/yum/vnc"
require "autorio/tasks/yum/nodelet"
require "autorio/tasks/yum/storlet"
require "autorio/tasks/yum/docker"
require "autorio/tasks/yum/wget_curl"
require "autorio/tasks/yum/reg_certs"

module Autorio
  class NativeTasks
    def self.master
      # ~~~ Commented for testing only. ~~~
      # %w(PkgTransport RepoSetup Update WgetCurl VNC)
      %w(PkgTransport)
    end

    def self.nodelet
      %w(PkgTransport RepoSetup Update WgetCurl Nodelet)
    end

    def self.storlet
      %w(PkgTransport RepoSetup Update WgetCurl Storlet)
    end

    def self.load(claz, from)
      Object.const_get("Autorio::" << "#{from}".capitalize << "::" << claz).new
    end
  end
end

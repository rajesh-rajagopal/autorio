require "sshkit"
require "autorio/platform"

module Autorio
  class Hosts
    attr_accessor :sshhosts
    attr_accessor :server_type

    class CouldNotFindFileError < StandardError
      def initialize(path)
        super(path)
      end
    end

    def initialize(server_type, params)
      @server_type = server_type
      @sshhosts = params.map { |k, v|
        v = v.transform_keys(&:to_sym)
        ensure_security(v, SSHKit::Host::new("#{ensure_user(v)}@#{k}"))
      }
    end

    def filter_unsupported
      unsupported = []

      @sshhosts.select do |sshhost|
        found = Platform.new.supported?(@sshhosts)
        is_unsupported_os = (found.length > 0)

        unsupported << found if is_unsupported_os
        is_unsupported_os
      end
    end

    def to_s
      puts @ssh_host.to_s
    end

    private

    def ensure_user(params)
      params[:user] || "root"
    end

    def ensure_security(params, host)
      password = params[:password]
      sshfile = params[:ssh]
      unless password
        raise CouldNotFindFileError::new(sshfile) unless Autorio::Util::File.exists?(sshfile)
        host.ssh_options = {
          keys: %w(sshfile),
          forward_agent: false,
          auth_methods: %w(publickey password),
        }
      end
      host.password = password if password
      host
    end
  end
end

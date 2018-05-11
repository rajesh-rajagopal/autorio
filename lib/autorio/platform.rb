require "sshkit"
require "sshkit/dsl"
require "airbrussh"

CHECK_CMD = '-c "import platform;print(platform.linux_distribution())"'

module Autorio
  class Platform
    include SSHKit::DSL
    YUM = "yum".freeze
    DEB = "deb".freeze

    def self.distro_type(props)
      return YUM unless props.platform_array.find { |p| /'ubuntu'|'debian'/ =~ p.downcase }
      DEB
    end

    def probed(host)
      host.properties.platform_array = host.properties.platform.scan(/'.*?'/).map { |p| p.downcase }
      all_good(host.hostname, host.properties.platform_array)
    end

    def supported?(sshhosts)
      sshhosts.each do |sshhost|
        on sshhost do |sshost|
          sshost.properties.platform = capture(:python, CHECK_CMD)
        end
        probed(sshhost)
      end
    end

    private

    def all_good(hostname, platform_array)
      platform_array.each do |x|
        unless x =~ /'ubuntu'|'debian'|'centos'/
          return platform_array.map { |x| " #{hostname} - Probed #{platform_array.to_s}. \n{x} is an Unsupported operating system." }
        end
      end
      platform_array.each do |x|
        unless x =~ /'18.04'|'8'|'9'|'16.04'|'7.1'/
          return platform_array.map { |x| " #{hostname} - Probed #{platform_array.to_s}. \n{x} is an Unsupported operating system version." }
        end
      end
    end
  end
end

require "sshkit"
require "sshkit/dsl"
require "airbrussh"

module Autorio
  class Runner
    include SSHKit::DSL

    def hosts
    end

    def container_tasks
    end

    def native_tasks
    end

    def deploy
      hosts.each do |sshhost|
        yd = yum_or_deb(sshhost.properties)
        native_tasks.each do |clas|
          on sshhost do |sshost|
            clz = NativeTasks.load(clas, yd)
            if ["sudo", clz.deploy].flatten.join(" ")
              puts " Hooray!"
            end
            upload! clz.upload[:from], clz.upload[:to] if clz.respond_to?(:upload)
          end
        end
      end

      #this is messy, the tasks must have types like
      # ExecuteRunner   with run method.
      # UploadRunner    with run method.
      # DownloadRunner  with run method.
      # Just call exec.run here.
      container_tasks.each do |t|
        hosts.each do |sshhost|
          on sshhost do |sshost|
            if test ["sudo", t.deploy].flatten.join(" ")
              puts " YeyHaw!"
            end
            upload! t.upload[:from], t.upload[:to] if t.respond_to?(:upload)
            t.after_deploy
          end
        end
      end
    end

    def clean
      container_tasks.each do |t|
        hosts.each do |sshhost|
          on sshhost do |sshost|
            if test ["sudo", t.clean].flatten.join(" ")
              puts " Awesome!"
            end
          end
        end
      end
      hosts.each do |sshhost|
        yd = yum_or_deb(sshhost.properties)
        native_tasks.reverse.each do |clas|
          on sshhost do |sshost|
            clz = NativeTasks.load(clas, yd)
            if test ["sudo", clz.clean].flatten.join(" ")
              puts " Fanstastic!"
            end unless clz.respond_to?(:upload)
          end
        end
      end
    end

    private

    def yum_or_deb(props)
      Platform.distro_type(props)
    end
  end
end

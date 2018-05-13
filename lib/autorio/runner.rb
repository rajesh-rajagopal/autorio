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
            execute clz.deploy unless clz.respond_to?(:upload)
            upload clz.upload[:from], clz.upload[:to] if clz.respond_to?(:upload)
          end
        end
      end

      #this is messy, the tasks must have types like
      # Execute
      # Upload
      # Download
      # Just call <task>.execute here.
      container_tasks.each do |t|
        hosts.each do |sshhost|
          on sshhost do |sshost|
            execute t.deploy unless t.respond_to?(:interaction_lamda)
            upload t.upload[:from], t.upload[:to] if t.respond_to?(:upload)
            execute(t.deploy, interaction_handler: t.interaction_lamda) if t.respond_to?(:interaction_lamda)
            t.after_deploy
          end
        end
      end
    end

    def clean
      container_tasks.each do |t|
        hosts.each do |sshhost|
          on sshhost do |sshost|
            execute t.clean
          end
        end
      end
      hosts.each do |sshhost|
        yd = yum_or_deb(sshhost.properties)
        native_tasks.reverse.each do |clas|
          on sshhost do |sshost|
            clz = NativeTasks.load(clas, yd)
            execute clz.clean unless clz.respond_to?(:upload)
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

require "autorio/util/serialization"

module Autorio
  class Config
    require "autorio/config/params.rb"
    require "yaml"
    require "rainbow"

    class << self
      Autorio::Params::CONFIG_PARAMS.each do |v|
        attr_accessor v
      end

      def what_version
        self.selected_version || self.version
      end

      def instance_values
        Hash[instance_variables.map { |name| [name[1..-1], instance_variable_get(name)] }]
      end

      def config_from_hash(data = {})
        data.each do |param, value|
          if Autorio::Params::CONFIG_PARAMS.include?(param.to_sym)
            instance_variable_set("@#{param}", value)
          else
            warn "Warning - No config parameter found for '#{param}'. Perhaps you have an erroneous entry in your yaml file?"
          end
        end
      end

      def config_from_yaml(file)
        build_data = Autorio::Util::Serialization.load_yaml(file)
        config_from_hash(build_data)
      end

      def config_to_hash
        data = {}
        Autorio::Params::CONFIG_PARAMS.each do |param|
          data.store(param, instance_variable_get("@#{param}"))
        end
        data
      end

      def default_project_root
        defined?(PROJECT_ROOT) ? File.expand_path(PROJECT_ROOT) : File.expand_path(File.join(LIBDIR, ".."))
      end

      def load_default_configs
        default_build_defaults = File.join(@project_root, "config.yaml")

        [default_build_defaults].each do |config|
          if File.readable? config
            config_from_yaml(config)
          else
            puts "   ✘ skip load #{default_build_defaults}".colorize(:red)
            @project_root = nil
          end
        end
      end

      def load_defaults
        @project_root ||= default_project_root
      end

      def print_config
        config_to_hash.each { |k, v| puts "#{k}: #{v}" }
      end

      def string_to_array(str)
        delimiters = /[,\s;]/
        return str if str.respond_to?("each")
        str.split(delimiters).reject(&:empty?).map(&:strip)
      end
    end
  end
end

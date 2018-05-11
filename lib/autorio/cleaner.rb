module Autorio
  class Cleaner
    attr_accessor :args

    def initialize(args)
      @args = args
    end

    def choice
      selected_version = Autorio::Util.select(Rainbow("Choose version ").cyan.bold, Autorio::Version.new(Autorio::Config.version).last_two)
      Autorio::Config.selected_version = selected_version
    end

    def proceed
      case @args[:which]
      when "master"
        Autorio::Master.new(args).clean if Autorio::Util.ask_yes_or_no(Rainbow("Confirm ?").white.bold)
      when "nodelet"
        Autorio::Nodelet.new(args).clean if Autorio::Util.ask_yes_or_no(Rainbow("Confirm ?").white.bold)
      when "storlet"
        Autorio::Storlet.new(args).clean if Autorio::Util.ask_yes_or_no(Rainbow("Confirm ?").white.bold)
      else
        Autorio::Master.new(args).clean if Autorio::Util.ask_yes_or_no(Rainbow("Confirm ?").white.bold)
      end
    end

    def clean
      choice
      proceed
    end
  end
end

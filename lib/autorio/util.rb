# Utility methods used by the various rake tasks

module Autorio::Util
  require "benchmark"
  require "base64"
  require "tty-prompt"
  require "autorio/util/file"
  require "autorio/util/serialization"
  require "autorio/util/rake_utils"

  def self.rand_string
    rand.to_s.split(".")[1]
  end

  def self.ask_yes_or_no(question)
    TTY::Prompt.new.yes?(question) do |q|
      q.default false
    end
  end

  def self.select(question, choices)
    TTY::Prompt.new.select(question, choices)
  end
end

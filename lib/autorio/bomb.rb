module Autorio::Bomb
  def explode(e)
    puts Rainbow(e.message).red
    print "\r" << (" " * 50) << "\n"
    stacktrace = e.backtrace.map do |call|
      if parts = call.match(/^(?<file>.+):(?<line>\d+):in `(?<code>.*)'$/)
        file = parts[:file].sub /^#{Regexp.escape(File.join(Dir.getwd, ""))}/, ""
        line = "#{colorize(file, 36)} #{colorize("(", 37)}#{colorize(parts[:line], 32)}#{colorize("): ", 37)} #{colorize(parts[:code], 31)}"
      else
        line = colorize(call, 31)
      end
      line
    end
    puts "Fatal error:\n"
    stacktrace.each { |line| puts line }
  end

  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def log_exception(exception)
    trace = filter_exception(exception) if exception
    unless trace.empty?
      log_trace(trace)
      ascii_bomb
    end
  end

  #just show our stuff .
  def filter_exception(exception, by = "autorio")
    puts "\033[1m\033[32m ✗✗✗ #{exception.message}\033[0m\033[22m"
    exception.backtrace.grep(/#{Regexp.escape("#{by}")}/)
  end

  def log_trace(trace)
    trace = (trace.map { |ft| ft.split("/").last }).join("\n")
    puts "\033[1m\033[36m#{trace}\033[0m\033[22m"
  end

  def ascii_bomb
    puts "" "\033[31m
       ,--.!,
    __/   -*-
	,####.  '|`
	######
	`####'                !\033[0m\033[1mWe flunked!\033[22m
" ""
  end
end

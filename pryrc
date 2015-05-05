Pry.config.prompt = proc do |obj, _level, _|
  prompt = ''
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> "
end

Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "\e[31m#{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}\e[0m"
end

if defined?(Rails)
  require 'rails/console/app'
  require 'rails/console/helpers'
  TOPLEVEL_BINDING.eval('self').extend ::Rails::ConsoleMethods
end

begin
  require 'pry-meta'
  require 'awesome_print'

  Pry.config.print = proc { |output, value| output.puts value.ai }

  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish' if defined?(PryByebug)
rescue LoadError
  warn '=> Unable to load .pryrc requires'
end

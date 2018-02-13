# require 'rubygems'
# require 'awesome_print'
# require 'hirb'

# # hirb
# Hirb.enable
# old_print = Pry.config.print
# Pry.config.print = proc do |*args|
#   Hirb::View.view_or_page_output(args[1]) || old_print.call(*args)
# end

# # awesome_print
# Pry.config.print = proc { |output, value| output.puts value.ai }
# AwesomePrint.pry!

# Pry.config.prompt = proc do |obj, _level, _|
#   prompt = ''
#   prompt << "#{Rails.version}@" if defined?(Rails)
#   prompt << "#{RUBY_VERSION}"
#   "#{prompt} (#{obj})> "
# end

# Pry.config.exception_handler = proc do |output, exception, _|
#   output.puts "\e[31m#{exception.class}: #{exception.message}"
#   output.puts "from #{exception.backtrace.first}\e[0m"
# end

# if defined?(Rails)
#   begin
#     require "rails/console/app"
#     require "rails/console/helpers"
#     TOPLEVEL_BINDING.eval('self').extend ::Rails::ConsoleMethods
#   rescue LoadError => e
#     require "console_app"
#     require "console_with_helpers"
#   end
# end

# Pry.config.commands.alias_command 'cont', 'continue' rescue nil
# Pry.config.commands.alias_command 'st', 'step' rescue nil
# Pry.config.commands.alias_command 'ne', 'next' rescue nil
# Pry.config.commands.alias_command 'fin', 'finish' rescue nil
# Pry.config.commands.alias_command 'r!', 'reload!' rescue nil

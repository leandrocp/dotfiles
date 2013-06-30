require 'rubygems'

require 'irb/completion'

require 'hirb'
require 'hirb/import_object'
Hirb.enable
extend Hirb::Console

require 'ap'

require 'pp'

IRB.conf[:AUTO_INDENT]=true

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

require 'wirble'
Wirble.init
Wirble.colorize

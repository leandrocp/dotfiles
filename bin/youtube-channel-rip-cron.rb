#!/usr/bin/env ruby

require 'psych'

channel_file = "#{ENV['HOME']}/.youtube-channels.yaml"

channels = Psych.load_file(channel_file)

channels.each_pair { |channel, location|
  %x(youtube-channel-rip.sh #{channel} 10 #{location})
}

#!/usr/bin/env ruby
require './jp2a_io.rb'
require './jp2a_interface.rb'
require './jp2a_ascpic.rb'
include AsciiPic
system "clear"
$running = 1
puts "Knowsys jp2a Enhancement Alpha 0.0001"
ascpic = Ascpic.new
ascpic.main_menu

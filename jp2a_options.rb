#!/usr/bin/env ruby
require './jp2a_io.rb'
require './jp2a_interface.rb'
require './jp2a_ascpic.rb'
require 'yaml'
include AsciiPic
system "clear"
$running = 1
$USERHOME = `echo $HOME`.chomp
puts "Knowsys jp2a Enhancement Alpha 0.1"
ascpic = Ascpic.new
ascpic.main_menu

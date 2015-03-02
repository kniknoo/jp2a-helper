module AsciiPic  
  class Ascpic
    include Input
    include Output
    include Interface
    def initialize
      read_settings
      @path = "#{$USERHOME}/Pictures/"
      @filename = "headshot2"
      @options ||= {
            colors: true,
            fill: true,
            border: true,
            invert: true,
            chars: "   ...,;:clodxhO0HXNWM",
            width: 40,
       }
    end
    
    def set_path
      old = @path
      puts "Current Path: #{@path}"
      puts "Set path"
      print "#{$USERHOME}/"
      clean_input("path")
      puts "Path set to #{@path}" unless @path == old
    end
    
    def set_file
      old = @filename
      puts "Current Filename: #{@filename}.jpg"
      print "Set Filename:"
      clean_input("filename")
      puts  "File name set to #{@filename}.jpg" unless @filename == old
    end
    
    def set_chars
      old = @options[:chars]
      puts "Current Character list: #{@options[:chars]}"
      puts "Press Enter to keep this list or"
      print "Select a new list of characters:"
      clean_input("chars")
      puts "Characters set to: #{@options[:chars]}" unless @options[:chars] == old
    end
    
    def set_width
      old = @options[:width]
      puts "Width is currently: #{@options[:width]}"
      print "Pick a new width:"
      clean_input("width")
      puts "Width set to #{@options[:width]}" unless @options[:width] == old
    end
    
    def toggle(option)
      @options[option.to_sym] = !@options[option.to_sym]
      system "clear"
      puts "#{option.capitalize}: #{@options[option.to_sym]}"
    end
  end
end

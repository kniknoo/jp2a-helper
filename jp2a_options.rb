#!/usr/bin/env ruby
class Ascpic
  def initialize
    @path = "Pictures"
    @filename = "headshot2"
    @outformat = ""
    @options = {
          colors: false,
          fill: false,
          invert: false,
          chars: "   ...,;:clodxhO0HXNWM",
          border: false,
          width: 40,
     }
     setargs
  end
  
  def set_path
    old = @path
    puts "Current Path: ~/#{@path}/"
    puts "Set path"
    print "~/"
    clean_input("path")
    puts "Path set to ~/#{@path}/" unless @path == old
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
  
  def clean_input(mode)
    input = gets.chomp
    system "clear"
    if input == ""
      puts "Cancelled"
      return
    end
    case mode
      when "filename"
        input = input[0...-4] if input[-4] == "."
        @filename = input
      when "path"
        input = input[0...-1] if input[-1] == "/"
        @path = input
      when "chars"
        input.delete!("\'\"\`")
        @options[:chars] = input
      when "width"
        if input.to_i == 0 
          puts "Invalid Number" 
        else 
          @options[:width] = input
        end
    end
  end
  
  def save_file(ext)
    case ext
      when "html" then @outformat = "--html > " 
      when "pdf" then @outformat = "--html | wkhtmltopdf - "
      when "txt" then @outformat = "> "
    end
    @outformat << "~/#{@path}/#{@filename}.#{ext}"
    process
    system "clear"
    puts "Saved to ~/#{@path}/#{@filename}.#{ext}"
  end
  
  def to_screen
    system "clear"
    process
    puts @output
  end
  
  def toggle(option)
    @options[option.to_sym] = !@options[option.to_sym]
    system "clear"
    puts "#{option.capitalize}: #{@options[option.to_sym]}"
  end
  
  def display_status
    puts "Working on: ~/#{@path}/#{@filename}.jpg"
    setargs
    puts "Arguments: #{@args.join(' ')}"
  end
  
  def chardivider
    divider = ""
    while divider.length < 77
      divider << @options[:chars]
      divider << @options[:chars].reverse
    end
    puts divider[0..77]
  end
  
  private
     
    def setargs
      @args = []
      @args << "--colors" if @options[:colors]
      @args << "--fill" if @options[:fill]
      @args << "-i" if @options[:invert]
      @args << "--chars='#{@options[:chars]}'"
      @args << "-b" if @options[:border]
      @args << "--width=#{@options[:width]}"
    end
     
    def process
      setargs
      @output = `jp2a #{@args.join(' ')} ~/#{@path}/#{@filename}.jpg #{@outformat}`
      @outformat = ""
    end
end
system "clear"
$running = 1
puts "Knowsys jp2a Enhancement Alpha 0.0001"
ascpic = Ascpic.new
while $running == 1
  puts "=============================================================================="
  ascpic.display_status
  puts "=============================================================================="
  ascpic.chardivider
  puts "=============================================================================="
  puts "Toggle (C)olors | Toggle (F)ill   | Toggle (B)order    | Toggle (I)nvert"
  puts "Change (W)idth  | Character (S)et | Change (D)irectory | File (N)ame" 
  puts "(A)nsi Preview  | Output to (p)df | Output to (h)tml   | Output to (T)ext"
  puts "(Q)uit"
  puts "=============================================================================="
  print "Make a selection:"
  selection = gets.chomp.downcase
  case selection
    when "a" then ascpic.to_screen
    when "p" then ascpic.save_file "pdf" 
    when "h" then ascpic.save_file "html" 
    when "t" then ascpic.save_file "txt" 
    when "c" then ascpic.toggle "colors"
    when "f" then ascpic.toggle "fill"
    when "b" then ascpic.toggle "border"
    when "i" then ascpic.toggle "invert"
    when "w" then ascpic.set_width
    when "s" then ascpic.set_chars
    when "d" then ascpic.set_path
    when "n" then ascpic.set_file
    when "q" then $running = 0; system "clear"
    else
      system "clear"
      puts "Invalid Selection"
  end
end

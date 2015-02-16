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
    puts "Current Path: ~/#{@path}/"
    puts "Set path"
    print "~/"
    path = gets.chomp
    path = path[0...-1] if path[-1] == "/"
    @path = path unless path == ""
    system "clear"
    puts "Path set to ~/#{@path}/"
  end
  
  def set_file
    puts "Current Filename: #{@filename}.jpg"
    print "Set Filename:"
    filename = gets.chomp
    filename = filename[0...-4] if filename[-4..-1] == ".jpg"
    if filename[-4] == "." 
      puts "Wrong file type: #{filename[-4..-1]}"
    else  
      @filename = filename unless filename == ""
    end
    system "clear"
    puts "File name set to #{@filename}.jpg"
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
  
  def set_width
    puts "Width is currently: #{@options[:width]}"
    print "Pick a new width:"
    width = gets.chomp.to_i
    system "clear"
    if width == 0
      puts "Invalid Number"
      return
    else
      @options[:width] = width
      puts "Width set to #{@options[:width]}"
    end
  end
  
  def set_chars
    puts "Current Character list: #{@options[:chars]}"
    puts "Press Enter to keep this list or"
    print "Select a new list of characters:"
    charlist = gets.chomp
    system "clear"
    charlist.delete!("\'") if charlist.include?("\'")
    charlist.delete!("\"") if charlist.include?("\"")
    charlist.delete!("\`") if charlist.include?("\`")
    return if charlist == ""
    @options[:chars] = charlist
    puts "Character set changed to: #{@options[:chars]}"
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
      puts "Invalid Selection"
  end
end

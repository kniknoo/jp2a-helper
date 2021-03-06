module Interface
  def display_status
    setargs
    puts "Working on: #{@path}#{@filename}.jpg"
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
  
  def main_menu
    while $running == 1
      puts "=============================================================================="
      display_status
      puts "=============================================================================="
      chardivider
      puts "=============================================================================="
      puts "Toggle (C)olors | Toggle (F)ill   | Toggle (B)order    | Toggle (I)nvert"
      puts "Change (W)idth  | Character (S)et | Change (D)irectory | File (N)ame" 
      puts "(A)nsi Preview  | Output to (p)df | Output to (h)tml   | Output to (T)ext"
      puts "(Q)uit"
      puts "=============================================================================="
      print "Make a selection:"
      selection = gets.chomp.downcase
      case selection
        when "a" then to_screen
        when "p" then save_file "pdf" 
        when "h" then save_file "html" 
        when "t" then save_file "txt" 
        when "c" then toggle "colors"
        when "f" then toggle "fill"
        when "b" then toggle "border"
        when "i" then toggle "invert"
        when "w" then set_width
        when "s" then set_chars
        when "d" then set_path
        when "n" then set_file
        when "q" then $running = 0; write_settings; system "clear"
        else
          system "clear"
          puts "Invalid Selection"
      end
    end
  end
end

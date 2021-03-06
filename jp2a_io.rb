module Input
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
        input << "/" unless input[-1] == "/"
        @path = "#{$USERHOME}/#{input}"
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
  
  def read_settings
    @options = YAML.load(File.open("settings.yml"))
  end
end

module  Output
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
    @ansioutput = `jp2a #{@args.join(' ')} #{@path}#{@filename}.jpg #{@outformat}`
    @outformat = ""
  end
    
  def save_file(ext)
    @outformat = ""
    case ext
      when "html" then @outformat = "--html > " 
      when "pdf" then @outformat = "--html | wkhtmltopdf - "
      when "txt" then @outformat = "> "
    end
    @outformat << "#{@path}#{@filename}.#{ext}"
    process
    system "clear"
    puts "Saved to #{@path}#{@filename}.#{ext}"
  end
  
  def to_screen
    system "clear"
    process
    puts @ansioutput
  end
  
  def write_settings
    File.open("settings.yml", "w") {|file| file.write(@options.to_yaml)}
  end
end

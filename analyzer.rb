require 'pry'
class Analyzer
  def initialize(directory)
    @dir = directory
    @results = []
    files.each { |file|
      @results << "\n"
      @results << file
      parse_file(file)
    }
  end

  def files
    `find #{@dir} -type f -name "*.rb"`.split(/\n/)
  end

  def parse_file(path)
    binding.pry
    lines = File.readlines(path)
    lines.each { |l|
      @results << l if l =~ /\s+class\s+|class\s+|\s+module\s+|module\s+|def\s+|\s+def\s+/
    }
  end

  def to_file
    @results.unshift("#{@dir} directory analysis!")
    File.open("results.txt", "w") { |f|
      f.puts @results
    }
  end

end

anal = Analyzer.new("path")

anal.to_file

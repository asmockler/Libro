class Book
	attr_accessor :chapters, :title, :author

	def initialize
		Kernel::print "Title: "
		@title = gets.chomp

		Kernel::print "Author: "
		@author = gets.chomp

		@chapters = Array.new
	end

	def add_chapter (chapter)
		@chapters.push chapter
	end

	def print
		puts "\n\n\n#{@title}\n#{@author}"
		@chapters.each do |c|
			c.print
		end
		puts "\n\n"
	end

	def check_new_chapter (format, line)
		new_chapter = false
		format = format.downcase

		if (format == "num" || format == "number")
			if (line[0..6].downcase == "chapter") # && line.length < 10)
				new_chapter = true
			else 
				new_chapter = false
			end
		elsif (format == "short")
			if line.downcase.strip.unstringify > -1
				new_chapter = true
			else 
				new_chapter = false
			end
		elsif (format == "string")
			if (line[0..6].downcase == "chapter" && line[8..line.length].downcase.strip.unstringify > -1)
				new_chapter = true
			else
				new_chapter = false
			end
		end
		
		return new_chapter
	end
end
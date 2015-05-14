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
end
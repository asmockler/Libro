class Chapter
	@@number = 0

	attr_accessor :text, :chapter_no

	def initialize
		@chapter_no = @@number
		@@number += 1
		@text = Array.new
	end

	def add_paragraph (text)
		@text.push text
	end

	def print
		puts "\n\nChapter #{@chapter_no}"
		@text.each do |p|
			puts "\n#{p}"
		end
	end
end
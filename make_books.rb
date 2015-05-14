require 'prawn'
require 'json'

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

class Chapter
	@@number = 1

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


book = Book.new

print "File: "
file = gets.chomp

chapter = nil
paragraph = ""

File.readlines(file).each do |line|
	# This means it is the end of a paragraph
	if line.length == 1
		chapter.add_paragraph(paragraph)
		paragraph = ""
	# This is the start of a Chapter
	elsif line[0..6].downcase == "chapter"

		if chapter
			# Save the preceding chapter
			chapter.add_paragraph(paragraph)
			book.add_chapter(chapter)
		end

		# Start a new chapter
		chapter = Chapter.new
		paragraph = ""
	elsif line["\n"]
		line = line.gsub(/\n/, " ")
		paragraph << line
	end
end

# Get the last chapter
chapter.add_paragraph(paragraph)
book.add_chapter(chapter)

# Print it for testing purposes
book.print
# book.chapters.each do |c|
# 	puts c 
# end


# FOR CREATING PDF

Prawn::Document.generate("#{book.title}.pdf") do
	
	# Configure Output
	font "Times-Roman"

	# Title Page
	move_down 250
	text book.title,		:align => :center, :size => 50
	move_down 30
	text book.author,		:align => :center, :size => 30
	start_new_page()

	book.chapters.each do |c|
		move_down 100
		text "Chapter #{c.chapter_no}", 	:align => :center, :size => 30
		move_down 20
		c.text.each do |p|
			text p
			move_down 12
		end
		start_new_page()
	end
end

# Prawn::Document.generate("hello.pdf") do
# 	book.chapters.each do |chapter|
# 		text chapter['heading'],    :align => :center, :size => 20
# 		move_down 12
# 		chapter.text.each do |p|
# 			text p
# 			move_down 8
# 		end
# 		start_new_page()
# 	end
# end













require 'prawn'
require 'json'
require_relative 'book'
require_relative 'chapter'

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
# book.print


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
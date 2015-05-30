require 'prawn'
require 'json'
require_relative 'lib/book'
require_relative 'lib/chapter'
require_relative 'lib/string_int'

# TODO
	# Throw an error in the Book#check_new_chapter method if an invalid format is passed
	# Page numbers

book = Book.new

print "File: "
file = gets.chomp

print "Chapter Heading Format: "	# "num", "number"	=> "Chapter 1", "Chapter 2"
									# "short"			=> "One", "Two", "Three"
									# "string"			=> "Chapter One", "Chapter Two"
chapter_format = gets.chomp

chapter = Chapter.new
paragraph = ""

File.readlines(file).each do |line|
	# This means it is the end of a paragraph
	if line.length == 1
		chapter.add_paragraph(paragraph)
		paragraph = ""
	# This is the start of a Chapter
	elsif book.check_new_chapter(chapter_format, line)

		if chapter
			# Save the preceding chapter
			chapter.add_paragraph(paragraph)
			unless chapter.chapter_no == 0
				book.add_chapter(chapter)
			end
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

Prawn::Document.generate("#{book.title}.pdf",
						 :page_size => "B5",
						 :margin => [50, 75, 75, 75],
						 :align => :justified) do
	

	# Configure Output
	font "/Library/Fonts/CrimsonText-Roman.ttf"

	# Title Page
	text book.title,		:valign => :center, :align => :center, :size => 50
	mode_down 25
	text book.author,		:valign => :center, :align => :center, :size => 30
	start_new_page()

	book.chapters.each do |c|
		start_new_page()
		move_down 100
		text "Chapter #{c.chapter_no}", 	:align => :center, :size => 30
		move_down 20
		c.text.each do |p|
			text p,							:align => :justify
			move_down 12
		end
	end

    number_pages "<page>", 		{:start_count_at => 1,
                                 :page_filter => :even,
     							 :at => [bounds.right - 50, bounds.bottom - 20],
                                 :align => :right,
                                 :size => 10}

	number_pages "<page>", 		{:start_count_at => 2,
	                             :page_filter => lambda{ |pg| pg != 1 && pg % 2 > 0 },
								 :at => [bounds.left, bounds.bottom - 20],
	                             :align => :left,
	                             :size => 10}

end
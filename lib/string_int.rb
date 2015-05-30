class Integer
	def stringify
		s = ""

		case self
		when 0 			then s = "zero"
		when 1			then s = "one"
		when 2			then s = "two"
		when 3			then s = "three"
		when 4			then s = "four"
		when 5			then s = "five"
		when 6			then s = "six"
		when 7			then s = "seven"
		when 8			then s = "eight"
		when 9			then s = "nine"
		when 10			then s = "ten"
		when 11			then s = "eleven"
		when 12			then s = "twelve"
		when 13			then s = "thirteen"
		when 14			then s = "fourteen"
		when 15			then s = "fifteen"	
		when 16			then s = "sixteen"
		when 17			then s = "seventeen"
		when 18			then s = "eighteen"
		when 19			then s = "nineteen"
		when 20..29 	then s = "twenty " + (self - 20).stringify
		when 30..39		then s = "thirty " + (self - 30).stringify
		when 40..49		then s = "forty " + (self - 40).stringify
		when 50..59		then s = "fifty " + (self - 50).stringify
		when 60..69		then s = "sixty " + (self - 60).stringify
		else				 s = nil
		end

		return s
	end
end

class String
	def unstringify
		i = -1

		case self
		when "zero"			then i = 0
	    when "one"			then i = 1
		when "two"			then i = 2
		when "three"		then i = 3
		when "four"			then i = 4
		when "five"			then i = 5
		when "six"			then i = 6
		when "seven"		then i = 7
		when "eight"		then i = 8
		when "nine"			then i = 9
		when "ten"			then i = 10
		when "eleven"		then i = 11
		when "twelve"		then i = 12
		when "thirteen"		then i = 13
		when "fourteen"		then i = 14
		when "fifteen"		then i = 15
		when "sixteen"		then i = 16
		when "seventeen"	then i = 17
		when "eighteen"		then i = 18
		when "nineteen"		then i = 19
		end

		# If none of those worked...
		if i == -1
			if self[0..5] == "twenty"
				i = 20 + self[7..self.length].unstringify
			elsif self[0..5] == "thirty"
				i = 30 + self[7..self.length].unstringify
			elsif self[0..4] == "forty"
				i = 40 + self[6..self.length].unstringify
			elsif self[0..4] == "fifty"
				i = 50 + self[6..self.length].unstringify
			elsif self[0..4] == "sixty"
				i = 60 + self[6..self.length].unstringify
			end
		end

		return i
	end
end
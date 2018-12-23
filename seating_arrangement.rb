class SeatingArrangement
	def initialize
	 	@blocks = {}
		@max_r = 0
		@max_c = 0
		@total_block = 4
		@seat_blocks = {}
		@seat_no = 1
		@seat_types = ['-A-', '-W-', '-C-']
	end

	def get_user_input
		@total_block.times do |b|
			c, r = gets.chomp.split(/\s/).map(&:to_i)
			@max_r = r if @max_r < r
			@max_c = c if @max_c < c
			@blocks[b+1] = {r: r, c: c}
		end
	end

	def init_seat_types
		@blocks.each do |block_no, size|
		temp = {}
		if size[:c] == 1
			@max_r.times do |r|
				temp[r+1] = []
				size[:c].times do |c|
					temp[r+1] << (r+1 <= size[:r] ? '-A-' : '---')
				end
			end
		else
			@max_r.times do |r|
				temp[r+1] = []
				size[:c].times do |c|
					if c+1 <= size[:c] && r+1 <= size[:r]
					  if c+1 == 1
					  	temp[r+1] << (block_no == 1 ? '-W-' : '-A-')
					  elsif c+1 == size[:c]
					  	temp[r+1] << (block_no == @total_block ? '-W-' : '-A-')
					  else
					  	temp[r+1] << '-C-'
					  end
					 else
					   temp[r+1] << '---' 
					end
				end
			end
		end
		@seat_blocks[block_no] = temp
	    end
	end

	def fill_seats(n)
		@seat_types.each do |type|
			@max_r.times do |r|
			   @total_block.times do |block_no|
			     seats = @seat_blocks[block_no+1][r+1]
			     seats.each_with_index do |seat, index|
			       if seat == type && @seat_no <= n
			         @seat_blocks[block_no+1][r+1][index] = "%03d" % @seat_no
			         @seat_no += 1
			         break if @seat_no > n
			       end
			     end  
			   end  
			end
		end
	end

	def show_seats(n)
		@max_r.times do |i|
		   @total_block.times do |j|
		     print (@seat_blocks[j+1][i+1]).join(' ')
		     print ' | ' if j+1 < @total_block
		   end  
		puts ''
	    end
    end

end

sa = SeatingArrangement.new
n = gets.chomp.to_i
sa.get_user_input
sa.init_seat_types
sa.fill_seats(n)
sa.show_seats(n)
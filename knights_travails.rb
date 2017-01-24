class Position
	attr_accessor :position, :potential, :previous
	attr_reader :row, :col
	def initialize(position, parent=nil)
		@position = position
		@potential = Array.new
		@row = position[0]
		@col = position[1]
		@previous = parent
	end
end

def find_positions(position_instance)
	offset = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2]]
	current = position_instance

	offset.each do |x|
		new_position = [x[0] + current.row, x[1] + current.col]
		if (0..7).include?(new_position[0]) and (0..7).include?(new_position[1])
			current.potential << Position.new(new_position, current)
		end
	end
	check_positions(current.potential)
end

def check_positions(potential_array)






	




def knight_moves(initial, target)
	initial = Position.new(initial)
	find_positions(initial)
end

knight_moves([0, 0], 0)


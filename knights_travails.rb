class Position
	attr_accessor :position, :children, :previous, :parent
	attr_reader :row, :col
	def initialize(position)
		@position = position
		@row = position[0]
		@col = position[1]
		@children = Array.new
		@parent = Array.new
	end
end

class PositionTree
	def initialize(initial, target)
		@initial = Position.new(initial)
		@target = target
		@path = []
	end

	def backwards_search
		queue = [forwards_search]
		until queue.empty?
			return if queue.first.position == @initial
			queue.first.parent.each do |parent|
				queue << parent
			end
			@path << queue.first
			queue.shift
		end
	end

	def forwards_search
		queue = [@initial]
		until queue.empty?
			return queue.first if queue.first.position == @target
			find_children(queue.first)
			queue.first.children.each do |child|
				queue << child
			end
			queue.shift
		end
		return nil
	end

	def find_children(node)
		offset = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2]]

		offset.each do |x|																	#Adds the offsets from the current position
			new_position = [x[0] + node.row, x[1] + node.col]								#and checks to see if they fit on the board
			if (0..7).include?(new_position[0]) and (0..7).include?(new_position[1])
				child = Position.new(new_position)
				node.children << child
				child.parent << node
			end
		end
	end

	def path
		forwards_search
		backwards_search
		return @path		
	end
end








pt = PositionTree.new([3,3], [4,3])
puts pt.path




